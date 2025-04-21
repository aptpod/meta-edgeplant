DESCRIPTION = "EDGEPLANT Raspberrypi power managemant tool"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit systemd

SRC_URI += "file://edgeplant_powermanage \
            file://edgeplant-faultlog.service \
"

PR="r0"

COMPATIBLE_MACHINE = "edgeplant-r1"

RDEPENDS:${PN} += "bash"
INSANE_SKIP:${PN} += "already-stripped"

FILES:${PN} = "/usr/bin  ${systemd_system_unitdir}"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
    install -d ${D}/usr/bin
    install -d ${D}${systemd_system_unitdir}

	install -m 0755 ${WORKDIR}/edgeplant_powermanage ${D}/usr/bin
    install -m 0644 ${WORKDIR}/edgeplant-faultlog.service ${D}${systemd_system_unitdir}
}

SYSTEMD_SERVICE:${PN} = "edgeplant-faultlog.service"
