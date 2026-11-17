local stringify = pandoc.utils.stringify
local lower = pandoc.text.lower

local function slug(s)
  return (lower(s):gsub("[%.,;:%(%)%[%]!%?'\"/\\]", ""):gsub("%s+", "-"))
end

local function block_anchor(id) return "blk-" .. id end

function Header(h)
  h.identifier = slug(stringify(h.content))
  return h
end

function Link(l)
  if not l.classes:includes("wikilink") then return nil end
  local target = l.target
  if target:sub(1, 1) ~= "#" then return l.content end

  local ref = target:sub(2)
  local label = l.content
  if stringify(label) == target then
    label = { pandoc.Str((ref:gsub("^%^", ""))) }
  end
  if ref:sub(1, 1) == "^" then
    l.target = "#" .. block_anchor(ref:sub(2))
  else
    l.target = "#" .. slug(ref)
  end
  l.content = label
  l.classes = {}
  return l
end

local function find_attachment(name)
  local dir = pandoc.path.directory(PANDOC_STATE.input_files[1] or ".")
  for _, sub in ipairs({ "assets", "attachments", "" }) do
    local rel = sub == "" and name or (sub .. "/" .. name)
    local f = io.open(pandoc.path.join({ dir, rel }), "r")
    if f then f:close(); return rel end
  end
  return name
end

function Image(img)
  if img.classes:includes("wikilink") then
    img.src = find_attachment(img.src)
    img.classes = {}
  end
  img.caption = {}
  return img
end

function Math(m)
  local args = { "-F", "html", "-t" }
  if m.mathtype == "DisplayMath" then args[#args + 1] = "-d" end
  local ok, html = pcall(pandoc.pipe, "katex", args, m.text)
  if not ok then return nil end
  return pandoc.RawInline("html", (html:gsub("%s+$", "")))
end

function Note(n)
  return pandoc.Span(pandoc.utils.blocks_to_inlines(n.content), { class = "fn" })
end

local function strip_block_id(inlines)
  local last = inlines[#inlines]
  if not (last and last.t == "Str" and last.text:match("^%^[%w%-]+$")) then return nil end
  inlines:remove(#inlines)
  while #inlines > 0 and (inlines[#inlines].t == "Space" or inlines[#inlines].t == "SoftBreak") do
    inlines:remove(#inlines)
  end
  return last.text:sub(2)
end

local function take_task_marker(inlines)
  local first = inlines[1]
  if not (first and first.t == "Str" and (first.text == "☐" or first.text == "☒")) then
    return nil
  end
  inlines:remove(1)
  if inlines[1] and inlines[1].t == "Space" then inlines:remove(1) end
  return first.text == "☒"
end

local function decorate(inlines, id, checked)
  local out = pandoc.List(inlines)
  if id then out = pandoc.List({ pandoc.Span(out, pandoc.Attr(block_anchor(id))) }) end
  if checked ~= nil then
    if checked then out = pandoc.List({ pandoc.Span(out, pandoc.Attr("", { "done" })) }) end
    out:insert(1, pandoc.Span({}, pandoc.Attr("", checked and { "cb", "on" } or { "cb" })))
  end
  return out
end

local function soft_to_hard(inlines)
  return inlines:map(function(el)
    if el.t == "SoftBreak" then return pandoc.LineBreak() end
    return el
  end)
end

function Plain(p)
  local c = p.content
  local checked = take_task_marker(c)
  local id = strip_block_id(c)
  return pandoc.Plain(decorate(soft_to_hard(c), id, checked))
end

-- One source line is one block, as in Obsidian and Notion.
local function split_lines(inlines)
  local parts, cur = {}, pandoc.List()
  for _, el in ipairs(inlines) do
    if el.t == "SoftBreak" then
      parts[#parts + 1] = cur
      cur = pandoc.List()
    else
      cur:insert(el)
    end
  end
  parts[#parts + 1] = cur
  return parts
end

local function para_block(inlines)
  if #inlines == 1 and inlines[1].t == "Image" then
    return pandoc.Div({ pandoc.Plain(inlines) }, pandoc.Attr("", { "figure" }))
  end
  return pandoc.Para(inlines)
end

function Para(p)
  local c = p.content
  local checked = take_task_marker(c)
  local id = strip_block_id(c)
  local blocks = {}
  for _, part in ipairs(split_lines(c)) do
    blocks[#blocks + 1] = para_block(decorate(part, nil, checked))
    checked = nil -- only the first line carries the checkbox
  end
  if id then return pandoc.Div(blocks, pandoc.Attr(block_anchor(id))) end
  return blocks
end

function BulletList(l)
  for _, item in ipairs(l.content) do
    local b = item[1]
    local first = b and (b.t == "Plain" or b.t == "Para") and b.content[1]
    local is_task = first and (
      (first.t == "Span" and first.classes:includes("cb")) or
      (first.t == "Str" and (first.text == "☐" or first.text == "☒")))
    if not is_task then return nil end
  end
  return pandoc.Div({ l }, pandoc.Attr("", { "todo-list" }))
end

function Table(t)
  for i, spec in ipairs(t.colspecs) do
    t.colspecs[i] = { spec[1] }
  end
  return t
end

function Pandoc(doc)
  for i, b in ipairs(doc.blocks) do
    if b.t == "Header" and b.level == 1 then
      b.classes = { "doc-title" }
      doc.blocks[i] = b
      doc.meta.title = pandoc.MetaString(stringify(b.content))
      break
    end
  end
  return doc
end
