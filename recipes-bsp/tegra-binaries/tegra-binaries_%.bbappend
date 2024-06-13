FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

COMPATIBLE_MACHINE = "jasmine"

SRC_URI:append:jasmine = " \
    file://0001-change-console-to-uart1.patch \
    file://0002-use-denver-core.patch \
"
