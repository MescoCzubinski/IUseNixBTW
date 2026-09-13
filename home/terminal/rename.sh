#!/bin/sh

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

n=1
for file in *; do
    [ -f "$file" ] || continue

    ext="${file##*.}"

    if [ "$use_time" -eq 1 ] && [[ "$file" =~ ^([0-9]{8}) ]]; then
        date="${BASH_REMATCH[1]}"
        date="${date:0:4}_${date:4:2}_${date:6:2}"
        printf -v newname "%s_%s_%0*d.%s" "$date" "$prefix" "$width" "$n" "$ext"
    else
        printf -v newname "%s_%0*d.%s" "$prefix" "$width" "$n" "$ext"
    fi

    mv -- "$file" "$newname"
    n=$((n + 1))
done
