#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload example >>/tmp/polybar1.log 2>&1 & disown
  done
else
  polybar example --reload >>/tmp/polybar1.log 2>&1 & disown
fi

#polybar example >>/tmp/polybar1.log 2>&1 & disown
#polybar bar2 >>/tmp/polybar2.log 2>&1 & disown

echo "Bars launched..."
