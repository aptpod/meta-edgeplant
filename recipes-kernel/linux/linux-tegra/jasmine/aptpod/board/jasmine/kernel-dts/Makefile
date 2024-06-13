#
# Copyright (c) 2021, aptpod,Inc.
#

old-dtb := $(dtb-y)
old-dtbo := $(dtbo-y)
dtb-y :=
dtbo-y :=

makefile-path := jasmine/kernel-dts

dtb-$(CONFIG_ARCH_TEGRA_18x_SOC) += tegra186-aptpod-jb01-jasmine.dtb

ifneq ($(dtb-y),)
dtb-y := $(addprefix $(makefile-path)/,$(dtb-y))
dts-include += $(makefile-path)
endif
ifneq ($(dtbo-y),)
dtbo-y := $(addprefix $(makefile-path)/,$(dtbo-y))
endif

dtb-y += $(old-dtb)
dtbo-y += $(old-dtbo)
