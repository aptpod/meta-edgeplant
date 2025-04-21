#!/bin/bash -eu
#
# Copyright (c) 2023, aptpod,Inc.
#

PS3="Enter: "

function menu_select() {
    declare -n items=$1
    MENU_SELECT=

    select item in "${items[@]}"; do

        if [ "${REPLY}" = "q" ]; then
            exit 0
        fi

        for index in "${!items[@]}"; do
            if [ "$item" == "${items[$index]}" ]; then
                MENU_SELECT=$index
            fi
        done

        if [ -n "$MENU_SELECT" ]; then
            break
        else
            echo "Choose a number or Enter 'q' for exit"
        fi
    done
}
