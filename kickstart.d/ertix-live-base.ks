# ertix-live-base.ks
#
# Description:
# - Fedora Live Spin with Budgie Desktop Environment
#
# Maintainer(s):
# - Aris Ripandi      <ripandi@pm.me>

%include ertix-repo-base.ks
%include ertix-base.ks

%packages

@base-x
@core
@admin-tools
@development-tools
@development-libs
@networkmanager-submodules
adwaita-qt4
adwaita-qt5
at-spi2-atk
at-spi2-core
avahi
baobab
caribou
caribou-gtk2-module
caribou-gtk3-module
chromium
dconf
desktop-backgrounds-gnome
evince
evince-djvu
evince-nautilus
exfat-utils
fedora-workstation-backgrounds
file-roller
file-roller-nautilus
firefox
frei0r-plugins
fuse-exfat
geany
glibc-all-langpacks
glib-networking
gparted
gstreamer1-plugins-bad-free
gstreamer1-plugins-bad-free-extras
gstreamer1-plugins-bad-nonfree
gstreamer1-plugins-good
gstreamer1-plugins-good-extras
gvfs-afc
gvfs-afp
gvfs-archive
gvfs-fuse
gvfs-goa
gvfs-gphoto2
gvfs-mtp
gvfs-smb
ibus-gtk2
ibus-gtk3
ibus-qt
lame
libcanberra-gtk2
libcanberra-gtk3
libcurl
libpng12
libproxy-mozjs
librsvg2
libsane-hpaio
libva-intel-driver
libXScrnSaver
lrzsz
ModemManager
mousetweaks
nautilus
nautilus-sendto
NetworkManager-iodine-gnome
NetworkManager-l2tp-gnome
NetworkManager-libreswan-gnome
NetworkManager-openconnect-gnome
NetworkManager-openvpn-gnome
NetworkManager-pptp-gnome
NetworkManager-ssh-gnome
NetworkManager-vpnc-gnome
nss-tools
PackageKit-command-not-found
PackageKit-gtk3-module
pinentry-gnome3
powerline-fonts
ppp
qgnomeplatform
qt
qt5-qtbase
qt5-qtbase-gui
qt5-qtdeclarative
qt5-qtxmlpatterns
qt-settings
qt-x11
rdist
rp-pppoe
rygel
sane-backends
sane-backends-drivers-scanners
sane-backends-libs
scl-utils
screenfetch
simple-mtpfs
simple-scan
sushi
tracker
tracker-miners
wvdial
xdg-desktop-portal
xdg-desktop-portal-gtk
xdg-user-dirs
xdg-user-dirs-gtk

# save some space
-autofs
-acpid
-gimp-help
-desktop-backgrounds-basic
-aspell-*                   # dictionaries are big
-foomatic-db-ppds

# not match packages
-shim-aa64
-s390utils-base
-xorg-x11-drv-omap
-grub2-efi-aa64
-grub2-ppc64le
-python-ldap
-extlinux-bootloader
-ppc64-utils
-grub2-ppc64
-xorg-x11-drv-armsoc
-python-devel
-recordmydesktop
-s390utils
-grub2-efi-aa64-cdboot
-gstreamer1-plugin-mpg123

%end
