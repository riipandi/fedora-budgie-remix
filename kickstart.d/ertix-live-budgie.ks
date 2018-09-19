# ertix-live-budgie.ks
#
# Description:
# - Fedora Live Spin with Budgie Desktop Environment
#
# Maintainer(s):
# - Aris Ripandi      <ripandi@pm.me>


%include fedora-live-base.ks
%include fedora-live-minimization.ks
%include ertix-live-base.ks

# Budgie Repo by Alunux
repo --name="Budgie Desktop Stable by alunux" --baseurl=https://copr-be.cloud.fedoraproject.org/results/alunux/budgie-desktop-stable/fedora-$releasever-$basearch/ --cost=0
repo --name="Etcher Electron" --baseurl=https://resin-io.bintray.com/redhat --cost=0

%packages

etcher-electron
gnome-backgrounds
gnome-bluetooth
gnome-calculator
gnome-calendar
gnome-disk-utility
gnome-keyring-pam
gnome-mpv
gnome-screenshot
gnome-software
gnome-system-monitor
arc-theme
budgie-brightness-control-applet
budgie-desktop
budgie-pixel-saver-applet
budgie-screenshot-applet
lightdm
light-locker
pop-gtk-theme
pop-icon-theme
tilix

%end


%post

# TODO: Budgie desktop configuration
#gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/fedora-workstation/paisaje.jpg'
#gsettings set org.gnome.desktop.wm.preferences theme 'Pop'; gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Darker'
#gsettings set org.gnome.desktop.interface icon-theme "Pop"; gsettings set org.gnome.desktop.interface cursor-theme "Pop"
#gsettings set org.gnome.desktop.interface font-name           "'Fira Sans Book 10'"       # Cantarell Regular 10
#gsettings set org.gnome.desktop.wm.preferences titlebar-font  "'Fira Sans SemiBold 10'"   # Cantarell Bold 10
#gsettings set org.gnome.desktop.interface document-font-name  "'Roboto Slab Regular 11'"  # Sans Regular 10
#gsettings set org.gnome.desktop.interface monospace-font-name "'Fira Mono Regular 11'"    # Monospace Regular 10
#cat $pwddir | dconf load /com/gexperts/Tilix/

# budgie configuration

# create /etc/sysconfig/desktop (needed for installation)

# set output director for cups-pdf
sed -i "s|\("^Out" * *\).*|\1\${HOME}/Documents|" /etc/cups/cups-pdf.conf

# set selinux permission to permissive
perl -pi -e 's#(SELINUX=)(.*)#${1}permissive#' /etc/selinux/config

cat >> /etc/rc.d/init.d/livesys << EOF

# set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf

# set default session, otherwise login will fail
sed -i 's/^#user-session=.*/user-session=budgie/' /etc/lightdm/lightdm.conf

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# no updater applet in live environment
rm -f /etc/xdg/autostart/org.mageia.dnfdragora-updater.desktop

# and mark it as executable
chmod +x /home/liveuser/Desktop/liveinst.desktop

# this goes at the end after all other changes.
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

%end

