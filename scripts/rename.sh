#!/usr/bin/env bash

# batch-rename <dir>               rename files to <dir_name>_001.<ext>
# batch-rename <dir> --with_time   files starting with YYYYMMDD -> YYYY_MM_DD_<dir_name>_001.<ext>

if [ -z "$1" ]; then
    echo "Usage: $0 <directory> [--with_time]"
    exit 1
fi

dir="$1"
use_time=0
[ "$2" = "--with_time" ] && use_time=1

[ -d "$dir" ] || { echo "Not a directory: $dir"; exit 1; }

prefix="$(basename "$dir")"
prefix="$(printf '%s' "$prefix" | sed -E 's/([a-z0-9])([A-Z])/\1_\2/g; s/([A-Z]+)([A-Z][a-z])/\1_\2/g; s/([a-zA-Z])([0-9])/\1_\2/g')"
prefix="${prefix,,}"

cd "$dir" || exit 1

count=0
for file in *; do
    [ -f "$file" ] || continue
    count=$((count + 1))
done

width=$((${#count} + 1))
[ "$width" -lt 3 ] && width=3

tmp=".batch-rename.$$"
olds=()
news=()
n=1
for file in *; do
    [ -f "$file" ] || continue

    ext="${file##*.}"

    if [ "$use_time" -eq 1 ] && [[ "$file" =~ ^([0-9]{4})_?([0-9]{2})_?([0-9]{2}) ]]; then
        date="${BASH_REMATCH[1]}_${BASH_REMATCH[2]}_${BASH_REMATCH[3]}"
        printf -v newname "%s_%s_%0*d.%s" "$date" "$prefix" "$width" "$n" "$ext"
    else
        printf -v newname "%s_%0*d.%s" "$prefix" "$width" "$n" "$ext"
    fi

    mv -- "$file" "$tmp.$n" || exit 1
    olds+=("$tmp.$n")
    news+=("$newname")
    n=$((n + 1))
done

for i in "${!olds[@]}"; do
    mv -n -- "${olds[$i]}" "${news[$i]}"
done
