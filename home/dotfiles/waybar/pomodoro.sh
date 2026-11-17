state="${XDG_RUNTIME_DIR:-/tmp}/waybar-pomodoro"
duration=1800

if [ "$1" = toggle ]; then
  rm -f "$state.notified"
  if [ -e "$state" ]; then rm "$state"; else echo $(($(date +%s) + duration)) > "$state"; fi
  pkill -RTMIN+10 waybar
  exit
fi

if [ ! -e "$state" ]; then printf '{"text":"\xee\x80\x81","class":"idle"}\n'; exit; fi
left=$(($(cat "$state") - $(date +%s)))
if [ "$left" -le 0 ]; then
  left=0
  if [ ! -e "$state.notified" ]; then
    touch "$state.notified"
    notify-send -a Pomodoro "Pomodoro finished" "Time for a break"
  fi
fi
printf '{"text":"%02d:%02d","class":"running"}\n' $((left / 60)) $((left % 60))
