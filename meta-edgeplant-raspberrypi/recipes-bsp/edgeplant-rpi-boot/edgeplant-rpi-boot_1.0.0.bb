DESCRIPTION = "EDGEPLANT Raspberrypi boot tools"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit systemd

SRC_URI += "file://edgeplant-rpi-boot.service \
            file://reset-canusb.sh \
"

S = "${WORKDIR}"

RDEPENDS:${PN} += "bash raspi-gpio"

FILES:${PN} = "/usr/bin  ${systemd_system_unitdir}"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
    install -d ${D}/usr/bin
    install -d ${D}${systemd_system_unitdir}

	install -m 0755 ${S}/reset-canusb.sh ${D}/usr/bin
    install -m 0644 ${S}/edgeplant-rpi-boot.service ${D}${systemd_system_unitdir}
}

SYSTEMD_SERVICE:${PN} = "edgeplant-rpi-boot.service"
