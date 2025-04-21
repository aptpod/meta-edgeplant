#!/bin/bash -eu
#
# Copyright (c) 2023, aptpod,Inc.
#

function poweroff_if_needed() {
    echo "The power management settings will be upgraded after poweroff."
    read -r -e -p "Do you want to power off system? [y/N]: " select
    case $select in
        [Yy]* )
            echo "Power off system after 3sec..."
            sleep 3
            systemctl poweroff
            ;;
        * )
            ;;
    esac
}
