#!/bin/bash -eu

#
# Copyright (c) 2022, aptpod,Inc.
#

INTERNAL_CAN_RESET_GPIO=21
INTERNAL_CAN_CH1_PATH="/sys/bus/usb/devices/3-1:1.1"
CAN_RESET_RETRY_MAX=3
DWC2_RELOAD_RETRY_MAX=2

function reset_can() {
    raspi-gpio set ${INTERNAL_CAN_RESET_GPIO} dl
    raspi-gpio set ${INTERNAL_CAN_RESET_GPIO} dh
}

function check_can_connected() {
    local retry=0
    local max_retry=30

    while [ ${retry} -lt ${max_retry} ]; do
        if [ -e "${INTERNAL_CAN_CH1_PATH}" ]; then
            return 0
        fi
        retry=$((retry + 1))
        sleep 0.1
    done

    return 1
}

function reload_dwc2() {
    modprobe -r dwc2 || true
    modprobe dwc2 || true
}

function main() {
    dwc2_reload_retry=0

    reset_can

    while [ ${dwc2_reload_retry} -lt ${DWC2_RELOAD_RETRY_MAX} ]; do
        can_reset_retry=0
        while [ ${can_reset_retry} -lt ${CAN_RESET_RETRY_MAX} ]; do
            if check_can_connected; then
                return 0
            fi

            echo "[WARN] Internal CAN device is not connected. Reset again."
            reset_can
            can_reset_retry=$((can_reset_retry + 1))
        done

        echo "[WARN] Failed to reset internal CAN device. Try to reload dwc2."
        reload_dwc2
        dwc2_reload_retry=$((dwc2_reload_retry + 1))
    done

    echo "[ERROR] Failed to reset internal CAN device."
    return 1
}

main
