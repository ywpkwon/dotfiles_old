#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IS_RECORDING_PID=`pgrep -a -f record-keeper | cut -f1 -d' '`
IS_RECORDING_SH=$HOME/.config/i3/helper/record-keeper.sh

if [[ "$IS_RECORDING_PID" == "" ]]; then
  read -r X Y W H < <(slop -n -l -c 0.157,0.333,0.466,0.4 -f "%x %y %w %h")
  FILE_NAME=~/Videos/Screencast-$(date -Iseconds | cut -d'+' -f1).$1
  notify-send "Recording Start: $FILE_NAME"
  case "$1" in
    byzanz)
      byzanz-record -w $W -h $H -x $X -y $Y -c --exec="$IS_RECORDING_SH" $FILE_NAME >& /dev/null
      ;;
    gif)
      byzanz-record -w $W -h $H -x $X -y $Y -c --exec="$IS_RECORDING_SH" $FILE_NAME >& /dev/null
      ;;
    ogv)
      byzanz-record -a -w $W -h $H -x $X -y $Y -c --exec="$IS_RECORDING_SH" $FILE_NAME >& /dev/null

      if [[ "$2" == "--convert-to-gif" ]]; then
        sleep 1
        $DIR/convert-ogv-to-gif.sh $FILE_NAME | xclip -selection clipboard
      fi
      ;;
  esac
else
  notify-send "Recording ends."
  # polybar-msg hook is-recording 1
  kill $IS_RECORDING_PID
fi