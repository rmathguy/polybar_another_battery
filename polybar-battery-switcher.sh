#!/bin/bash
trap "toggle" USR1

BAT_INDEX_FILE="/tmp/polybar_battery_index"
BATTERY_STATUS_BIN="$HOME/random_bin/polybar-ab"  # adjust to your Go binary path

# Default battery
if [ ! -f "$BAT_INDEX_FILE" ]; then
  echo 0 > "$BAT_INDEX_FILE"
fi

BAT=$(cat "$BAT_INDEX_FILE")

sleep_pid=0
# This function handles switching between BAT0 and BAT1
toggle() {
   # Default battery
   if [ ! -f "$BAT_INDEX_FILE" ]; then
     echo 0 > "$BAT_INDEX_FILE"
   fi

   BAT=$(cat "$BAT_INDEX_FILE")
    if [ "$BAT" -eq 0 ]; then
        BAT=1
    else
        BAT=0
    fi
    # Update the gosh-darned file so that it actually does something!
     echo $BAT > "$BAT_INDEX_FILE"
     tail -n 25 /tmp/battery_module.log > /tmp/battery_module.tmp && mv /tmp/battery_module.tmp /tmp/battery_module.log
     echo "$(date '+%Y-%m-%d %H:%M:%S') Switched to BAT=$BAT" >> /tmp/battery_module.log
     
     if [ "$sleep_pid" -ne 0 ]; then
        kill $sleep_pid >/dev/null 2>&1
     fi
}

status() {
  while true; do
      tail -n 25 /tmp/battery_module.log > /tmp/battery_module.tmp && mv /tmp/battery_module.tmp /tmp/battery_module.log
      echo "$(date '+%Y-%m-%d %H:%M:%S') Running status for BAT=$BAT" >> /tmp/battery_module.log
      "$BATTERY_STATUS_BIN" --bat-index="$BAT" -polybar -once -font=6
      sleep 1 &
      sleep_pid=$!
      wait
   done
}

dual() {
  while true; do
      tail -n 25 /tmp/battery_module.log > /tmp/battery_module.tmp && mv /tmp/battery_module.tmp /tmp/battery_module.log
      echo "$(date '+%Y-%m-%d %H:%M:%S') Running status for BAT=$BAT" >> /tmp/battery_module.log
      "$BATTERY_STATUS_BIN" --all -polybar -once -font=6
      sleep 1 &
      sleep_pid=$!
      wait
   done
}


case "$1" in
  "toggle")
      toggle
    ;;
  "status")
      status
   ;;
  "dual")
      dual
   ;;
esac
