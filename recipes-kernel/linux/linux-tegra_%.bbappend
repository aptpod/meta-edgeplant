FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

COMPATIBLE_MACHINE = "jasmine"

SRC_URI:append:jasmine = "file://aptpod;subdir=git \
            file://0001-aptpod-Add-device-tree-path.patch \
            file://0001-aptpod-Use-aptpod-directory.patch \
            file://0001-fix-new-acpi-handle-support.patch \
            file://0001-fix-uvc-max-payload-transfer-size.patch \
            file://0001-patch-for-aptpod-dts.patch \
            file://tcp-cong.cfg \
           "

KBUILD_DEFCONFIG:jasmine ?= "jasmine_defconfig"

PACKAGE_ARCH = "${MACHINE_ARCH}"

# Force hash length to 12 for compatibility with package dependencies
set_gitconfig() {
    if [ "${SCMVERSION}" = "y" -a -d "${S}/.git" ]; then
        git --git-dir=${S}/.git config core.abbrev 12
    fi
}
do_kernel_checkout_remove[postfuncs] = "set_scmversion"
do_kernel_checkout[postfuncs] += "set_gitconfig"
do_kernel_checkout[postfuncs] += "set_scmversion"

# Force the use of the KBUILD_DEFCONFIG even if some other defconfig was generated in the ${WORKDIR}
do_kernel_metadata:prepend:jasmine () {
  [ -e ${WORKDIR}/defconfig ] && rm ${WORKDIR}/defconfig
  cp ${S}/aptpod/arch/arm64/configs/jasmine_defconfig ${S}/arch/arm64/configs
}

do_patch:append:jasmine () {
  # rename and use patched dts
  cp ${S}/nvidia/platform/t18x/quill/kernel-dts/tegra186-quill-p3489-0888-a00-00-base.dts ${S}/aptpod/board/jasmine/kernel-dts/tegra186-aptpod-jb01-jasmine.dts
}

