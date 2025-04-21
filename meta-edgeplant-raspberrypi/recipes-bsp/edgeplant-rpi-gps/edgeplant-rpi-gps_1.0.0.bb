DESCRIPTION = "EDGEPLANT Raspberrypi GPS tools"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit systemd

SRC_URI += "\
    file://start-gps.sh \
    file://edgeplant-rpi-gps.service \
    file://30-em7431-gps.rules \
"

S = "${WORKDIR}"

FILES:${PN} = "/usr/bin ${systemd_system_unitdir} ${sysconfdir}"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
    install -d ${D}/usr/bin
    install -d ${D}${systemd_system_unitdir}
    install -d ${D}${sysconfdir}/udev/rules.d

	install -m 0755 ${S}/start-gps.sh ${D}/usr/bin
    install -m 0644 ${S}/edgeplant-rpi-gps.service ${D}${systemd_system_unitdir}
	install -m 0644 30-em7431-gps.rules ${D}${sysconfdir}/udev/rules.d
}

SYSTEMD_SERVICE:${PN} = "edgeplant-rpi-gps.service"
