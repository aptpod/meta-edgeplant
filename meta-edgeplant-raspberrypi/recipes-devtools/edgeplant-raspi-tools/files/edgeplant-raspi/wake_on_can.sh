#!/bin/bash -eu
#
# Copyright (c) 2023, aptpod,Inc.
#

source "/usr/bin/edgeplant-raspi/menu_select.sh"
source "/usr/bin/edgeplant-raspi/poweroff.sh"

PWR_MANAGE=/usr/bin/edgeplant_powermanage

function select_bitrate() {
    declare -a bitrates=("33" "50" "83" "100" "125" "250" "500" "1000")
    menu_select bitrates

    echo "${bitrates[$MENU_SELECT]}"
}

function select_can_frame_format() {
    declare -a formats=("standard" "extended")
    menu_select formats

    echo "${formats[$MENU_SELECT]}"
}

function select_can_id() {
    local -r format=$1
    local -r type=$2
    local id_max="0x1FFFFFFF"

    if [ "$format" = "standard" ]; then
        id_max="0x7FF"
    fi

    read -r -e -p " - set id $type (0x0-$id_max): " id
    echo "$id"
}

WOC_FILTER_ARGS=""
function get_woc_filter_args() {
    local -r target=$1

    read -r -e -p "Use power $target id filter? [y/N]: " use_filter
    case $use_filter in
        [Yy]* )
            echo "Select power $target ID :"
            echo " - frame format:"
            local -r frame_format=$(select_can_frame_format)
            local -r id_mask=$(select_can_id "$frame_format" "mask")
            local -r id_filter=$(select_can_id "$frame_format" "filter")

            WOC_FILTER_ARGS="-t:$target -a:true -i:$frame_format -m:$id_mask -f:$id_filter"
            ;;
        * )
            WOC_FILTER_ARGS="-t:$target -a:false"
            ;;
    esac

}

function disable_woc() {
    "$PWR_MANAGE" woc -a:false

    poweroff_if_needed
}

function can_use_id_filter() {
    local -r funcs=$("$PWR_MANAGE" funcs)
    if [[ "$funcs" = *"CAN ID filter"* ]]; then
        return 0
    else
        return 1
    fi
}

function change_woc_and_filter_settings() {
    local -r timeout=$1
    local -r bitrate=$2

    get_woc_filter_args "on"
    local -r on_filter_cmd="$WOC_FILTER_ARGS"

    get_woc_filter_args "off"
    local -r off_filter_cmd="$WOC_FILTER_ARGS"

    if [[ "$off_filter_cmd" = *"-a:false"* ]] && [ "$timeout" = "0" ]; then
        echo "Invalid settings: timeout = 0 and power off filter = disable."
        exit 1
    fi

    if [ "$timeout" = "0" ]; then
        "$PWR_MANAGE" id_filter $on_filter_cmd
        "$PWR_MANAGE" id_filter $off_filter_cmd
        "$PWR_MANAGE" woc -a:true -t:"$timeout" -b:"$bitrate"
    else
        "$PWR_MANAGE" woc -a:true -t:"$timeout" -b:"$bitrate"
        "$PWR_MANAGE" id_filter $on_filter_cmd
        "$PWR_MANAGE" id_filter $off_filter_cmd
    fi
}

function change_woc_settings() {
    read -r -e -p "Time to power off after last CAN packet received (0-30[min]): " timeout

    echo "Select CAN bitrate [kbps]: "
    local -r bitrate=$(select_bitrate)

    if can_use_id_filter; then
        change_woc_and_filter_settings "$timeout" "$bitrate"
    else
        "$PWR_MANAGE" woc -a:true -t:"$timeout" -b:"$bitrate"
    fi

    poweroff_if_needed
}

function menu_change_woc_settings() {
    echo "--------------------------------------------------------------------------------"
    echo " Change Wake on CAN settings"
    echo "--------------------------------------------------------------------------------"

    declare -a activate=("disable" "enable")
    menu_select activate

    case $MENU_SELECT in
        0)
            disable_woc
            ;;
        1)
            change_woc_settings
            ;;
    esac
}

menu_change_woc_settings
