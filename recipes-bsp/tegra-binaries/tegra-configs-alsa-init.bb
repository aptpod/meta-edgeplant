DESCRIPTION = "Sound init configuration files for EDGEPLANT board"

COMPATIBLE_MACHINE = "jasmine"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI += "file://01-tegra-max9867.conf \
"

FILES:${PN}:jasmine = "${datadir}/alsa/init/postinit/"

do_compile[noexec] = "1"

do_install:jasmine () {
    install -d ${D}${datadir}/alsa/init/postinit
    install -m 0644 ${WORKDIR}/01-tegra-max9867.conf ${D}${datadir}/alsa/init/postinit
}
