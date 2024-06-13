DESCRIPTION = "EDGEPLANT L4T tools"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit systemd features_check

SRC_URI = "https://repository.aptpod.jp/edgeplant/jb01/dists/r32.7/stable/binary-arm64/edgeplant-l4t-tools_${PV}_arm64.deb"
SRC_URI[sha256sum] = "95eefab1914ccdccd344fe80dec96c3f83328436332359cfc5a1d3b07748568d"
PR = "r0"

S = "${WORKDIR}"

REQUIRED_DISTRO_FEATURES = "systemd"

RDEPENDS:${PN} += " \
    bash \
    python3-pyserial \
    i2c-tools \
"
INSANE_SKIP:${PN} += "already-stripped"

FILES:${PN} = "${bindir} ${systemd_system_unitdir}"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
    TOOLS_BIN_DIR="/usr/bin"
    TOOLS_UNIT_DIR="/lib/systemd/system"

    install -d ${D}${bindir}/edgeplant-l4t
    install -d ${D}${systemd_system_unitdir}

    install -m 0755 ${S}${TOOLS_BIN_DIR}/edgeplant-l4t-tools ${D}${bindir}
    install -m 0755 -t ${D}${bindir}/edgeplant-l4t ${S}/${TOOLS_BIN_DIR}/edgeplant-l4t/*

    install -m 0644 ${S}/${TOOLS_UNIT_DIR}/edgeplant-l4t-boot.service ${D}${systemd_system_unitdir}
    install -m 0644 ${S}/${TOOLS_UNIT_DIR}/edgeplant-l4t-faultlog.service ${D}${systemd_system_unitdir}
    install -m 0644 ${S}/${TOOLS_UNIT_DIR}/edgeplant-l4t-shutdown.service ${D}${systemd_system_unitdir}
}

SYSTEMD_SERVICE:${PN} = "edgeplant-l4t-boot.service edgeplant-l4t-faultlog.service edgeplant-l4t-shutdown.service"
