# Add arbitrary text to the config file.

# Enable IMU(LSM6DSO)
RPI_EXTRA_CONFIG:append:edgeplant-r1 = "\n\
dtoverlay=lsm6dso-i2c\n\
dtoverlay=i2c5,pins_12_13\n\
"

# Enable ADC(AD7994)
RPI_EXTRA_CONFIG:append:edgeplant-r1 = "dtoverlay=ad7994\n"

# Enable CAN-USB
RPI_EXTRA_CONFIG:append:edgeplant-r1 = "dtoverlay=can-usb\n"

# Enable RTC/EEPROM
RPI_EXTRA_CONFIG:append:edgeplant-r1 = "\n\
dtoverlay=i2c0,pins_44_45\n\
dtoverlay=mcp7940\n\
dtoverlay=eeprom-24lc32\n\
"

# Disable onboard Bluetooth/WiFi
RPI_EXTRA_CONFIG:append:edgeplant-r1 = "\n\
dtoverlay=disable-bt\n\
dtoverlay=disable-wifi\n\
"

# Enable Power management
RPI_EXTRA_CONFIG:append:edgeplant-r1 = "\n\
dtoverlay=gpio-shutdown,gpio_pin=6,active_low=0,gpio_pull=\"off\"\n\
dtoverlay=gpio-poweroff,gpiopin=7\n\
dtoverlay=uart4\n\
"

# Enable external microSD
RPI_EXTRA_CONFIG:append:edgeplant-r1 = "\n\
dtoverlay=sd0,overclock_50=50\n\
"

do_deploy:append() {
    CONFIG=${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt
    sed -i '/#force_turbo=/ c\force_turbo=1' $CONFIG
}
