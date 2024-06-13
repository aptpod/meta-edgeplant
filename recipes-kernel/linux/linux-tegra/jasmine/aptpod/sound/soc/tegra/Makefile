subdir-ccflags-y := -Werror

subdir-ccflags-y += -I$(srctree)
subdir-ccflags-y += -I$(srctree)/sound/soc/codecs/
subdir-ccflags-y += -I$(srctree.nvidia)
subdir-ccflags-y += -I$(srctree.nvidia)/sound/soc/tegra-virt-alt/
subdir-ccflags-y += -I$(srctree.nvidia)/sound/soc/tegra-alt/include/
subdir-ccflags-y += -I$(srctree.aptpod)/sound/soc/codecs/

#------------------------------------ machine drivers ---------------------------------------
snd-soc-tegra-machine-driver-jb01-objs := tegra_machine_driver_jb01.o

obj-$(CONFIG_SND_SOC_TEGRA186_JB01_ALT) += snd-soc-tegra-machine-driver-jb01.o
