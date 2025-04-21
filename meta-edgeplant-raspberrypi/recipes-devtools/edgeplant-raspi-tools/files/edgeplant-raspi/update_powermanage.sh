#!/bin/bash -eu
#
# Copyright (c) 2023, aptpod,Inc.
#

source "/usr/bin/edgeplant-raspi/menu_select.sh"

PM_FILE_NAME_PREFIX="$1"
PM_FILE_EXT="$2"

PWR_MANAGE=/usr/bin/edgeplant_powermanage
CURRENT_VERSION=""
NEW_VERSION=""

function update_powermanage() {
    echo "--------------------------------------------------------------------------------"
    echo " Update powermanage"
    echo "--------------------------------------------------------------------------------"
    echo "Current version: $CURRENT_VERSION"
    echo "New version: $NEW_VERSION"
    echo ""

    read -r -e -p "Update powermanage? [y/N]: " select
    case $select in
    [Yy]*)
        "$PWR_MANAGE" update -f:"$1"
        ;;
    *)
        echo "Update cancelled."
        ;;
    esac

}

function get_powermanage_version() {
    local -r path="$1"
    CURRENT_VERSION=$("$PWR_MANAGE" version | sed -e 's/version: //g')
    NEW_VERSION=$(echo "$path" | sed -e "s/.*${PM_FILE_NAME_PREFIX}\(.*\)\.${PM_FILE_EXT}/\1/g")
}

function update_powermanage_offline() {
    echo "--------------------------------------------------------------------------------"
    echo " Offline powermanage update"
    echo "--------------------------------------------------------------------------------"

    read -e -p "Update file path: " path

    if [ ! -f "$path" ]; then
        echo "Update file is not found."
        exit 1
    fi

    ext="${path##*.}"
    if [ ! "${PM_FILE_EXT}" = "$ext" ]; then
        echo "Invalid update file."
        exit 1
    fi

    get_powermanage_version "$path"
    update_powermanage "$path"
}

function menu_update_powermanage() {
    update_powermanage_offline
}

menu_update_powermanage
