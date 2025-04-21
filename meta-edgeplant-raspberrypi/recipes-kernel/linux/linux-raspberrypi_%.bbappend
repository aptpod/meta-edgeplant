FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

COMPATIBLE_MACHINE = "edgeplant-r1"

SRC_URI:append:edgeplant-r1 = "\
    file://adc.cfg \
    file://imu.cfg \
    file://usb.cfg \
    file://dts/overlays/ad7994-overlay.dts;subdir=git/arch/${ARCH}/boot \
    file://dts/overlays/can-usb-overlay.dts;subdir=git/arch/${ARCH}/boot \
    file://dts/overlays/lsm6dso-i2c-overlay.dts;subdir=git/arch/${ARCH}/boot \
    file://dts/overlays/mcp7940-overlay.dts;subdir=git/arch/${ARCH}/boot \
    file://dts/overlays/eeprom-24lc32-overlay.dts;subdir=git/arch/${ARCH}/boot \
    file://dts/overlays/sd0-overlay.dts;subdir=git/arch/${ARCH}/boot \
    file://firmware/renesas_usb_fw.mem;subdir=git \
"

KBUILD_DEFCONFIG:edgeplant-r1 ?= "bcm2711_defconfig"

PACKAGE_ARCH = "${MACHINE_ARCH}"
