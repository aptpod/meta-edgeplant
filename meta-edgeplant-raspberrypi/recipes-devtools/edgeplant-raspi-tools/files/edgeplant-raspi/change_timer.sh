#!/bin/bash -eu
#
# Copyright (c) 2023, aptpod,Inc.
#

source "/usr/bin/edgeplant-raspi/menu_select.sh"
source "/usr/bin/edgeplant-raspi/poweroff.sh"

PWR_MANAGE=/usr/bin/edgeplant_powermanage

function menu_change_timer() {
    echo "--------------------------------------------------------------------------------"
    echo " Change powermanage timer settings"
    echo "--------------------------------------------------------------------------------"

    read -r -e -p "Time to force power off after turning off ther ignition (1-30[min]): " time

    "$PWR_MANAGE" timer -f:"$time"

    poweroff_if_needed
}

menu_change_timer
