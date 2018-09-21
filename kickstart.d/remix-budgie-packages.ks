# remix-budgie-packages.ks
#
# Description:
# - Fedora Remix with Budgie Desktop Environment
#
# Maintainer(s):
# - Aris Ripandi      <ripandi@pm.me>

%packages

@networkmanager-submodules
@admin-tools
gnome-keyring-pam
system-config-printer

baobab
chromium
dconf
desktop-backgrounds-gnome
evince
evince-djvu
evince-nautilus
file-roller
file-roller-nautilus
geany
gparted
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
pinentry-gnome3
sushi
xdg-desktop-portal
xdg-desktop-portal-gtk
xdg-user-dirs
xdg-user-dirs-gtk

gnome-backgrounds
gnome-bluetooth
gnome-calculator
gnome-calendar
gnome-disk-utility
gnome-mpv
gnome-screenshot
gnome-software
gnome-system-monitor
arc-theme
asciinema
audacious
budgie-brightness-control-applet
budgie-desktop
budgie-pixel-saver-applet
budgie-screenshot-applet
lightdm
light-locker
nomacs
plymouth-plugin-script
pop-gtk-theme
pop-icon-theme
tilix
vokoscreen

# save some space
-autofs
-acpid
-gimp-help
-desktop-backgrounds-basic
-aspell-* # dictionaries are big
-foomatic-db-ppds
-fedora-release-notes
-gnome-abrt
-im-chooser
-opensc
-setroubleshoot
-system-config-language
-system-config-users
-yelp

%end
