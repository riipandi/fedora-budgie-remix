#
# Software Configuration
#
# part of Poliba Corse OS
#

%packages

@base-x
@guest-desktop-agents
@core
@fonts
-adobe-source-han-sans-cn-fonts
-adobe-source-han-sans-tw-fonts
-google-noto-sans-*
-lohit-*
-sil-*
-thai-scalable-waree-fonts
# Maybe add NetworkManager-adsl for oldies
@hardware-support
@gnome-desktop
-ModemManager
-NetworkManager-adsl
-NetworkManager-openconnect-gnome
-NetworkManager-pptp-gnome
-NetworkManager-ssh-gnome
-gnome-boxes
-gnome-classic-session
-gnome-documents
-gnome-getting-started-docs
-gnome-session-xsession
-gnome-user-docs
-yelp
@networkmanager-submodules

kernel
kernel-modules
kernel-modules-extra

# Installation
anaconda
@anaconda-tools
-gfs2-utils
-reiserfs-utils
dracut-live
memtest86+

# Userland Software
gcc
gcc-c++
nfs-utils
autofs
chromium
chromium-libs-media-freeworld
krita
telegram-desktop
transmission
virt-manager
# Customisation
arc-theme
numix-icon-theme
la-capitaine-cursor-theme

# Poliba Corse
## Original Content
polibacorse-os-backgrounds
plymouth-theme-polibacorse

## Virtualization
kernel-devel
kernel-headers
dkms

## Development
qt-creator
arduino
mosquitto
mosquitto-devel
json-c
python3-pip
python3-pyserial
python3-numpy
python3-matplotlib
python3-paho-mqtt
python3-pynmea2

## To be removed
python2-pynmea2

## Remove apps out-of-scope
-cheese
-gnome-calendar
-gnome-clocks
-gnome-contacts
-gnome-maps
-simple-scan
-gnome-todo
-totem
-gnome-weather

%end
