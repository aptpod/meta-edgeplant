# Fix Kernel panic - not syncing: Asynchronous SError Interrupt in PCIe
# https://github.com/raspberrypi/linux/issues/5659
CMDLINE:append:edgeplant-r1 = " pcie_aspm=off pcie_ports=compat pcie_port_pm=off"

# Added for debugging before the serial driver is activated
CMDLINE:append:edgeplant-r1 = " earlycon"
