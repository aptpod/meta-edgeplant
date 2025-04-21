DESCRIPTION = "EDGEPLANT Raspberrypi Tools"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit systemd

SRC_URI += "file://edgeplant-raspi-tools \
            file://edgeplant-raspi/change_timer.sh \
            file://edgeplant-raspi/menu_select.sh \
            file://edgeplant-raspi/poweroff.sh \
            file://edgeplant-raspi/update_powermanage.sh \
            file://edgeplant-raspi/wake_on_can.sh \
"

PR="r0"

COMPATIBLE_MACHINE = "edgeplant-r1"

S = "${WORKDIR}"

RDEPENDS:${PN} += "bash edgeplant-powermanage"

FILES:${PN} = "/usr/bin"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
    install -d ${D}/usr/bin
    install -d ${D}/usr/bin/edgeplant-raspi

	install -m 0755 ${S}/edgeplant-raspi-tools ${D}/usr/bin
	install -m 0755 ${S}/edgeplant-raspi/* ${D}/usr/bin/edgeplant-raspi
}
