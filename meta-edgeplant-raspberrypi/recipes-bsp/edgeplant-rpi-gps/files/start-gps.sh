#!/bin/sh

GPS_DEVICE_PATH="/dev/ttyGPS"

RETRY=20
function start_nmea() {
  local retry=0
  while [[ $retry -ne $RETRY ]]; do
    echo \$GPS_START > $GPS_DEVICE_PATH

    ret=$(timeout 1 cat $GPS_DEVICE_PATH)
    if [ -n "$ret" ]; then
      return 0
    fi
    retry=$((retry + 1))
  done
  echo "Failed to start GPS"
  return 1
}

if [ -e $GPS_DEVICE_PATH ]
then
    stty -F $GPS_DEVICE_PATH -icrnl 9600
    start_nmea
fi
