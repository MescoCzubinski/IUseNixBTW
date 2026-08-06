function Root:layout()
	self._chunks = ui.Layout()
		:direction(ui.Layout.VERTICAL)
		:constraints({
			ui.Constraint.Length(1),
			ui.Constraint.Length(Tabs.height()),
			ui.Constraint.Fill(1),
		})
		:split(self._area)
end

function Root:build()
	self._children = {
		Header:new(self._chunks[1], cx.active),
		Tabs:new(self._chunks[2]),
		Tab:new(self._chunks[3], cx.active),
		Modal:new(self._area),
	}
end
