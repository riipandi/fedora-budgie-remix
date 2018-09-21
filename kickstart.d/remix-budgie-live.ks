# remix-budgie-live.ks
#
# Description:
# - Fedora Remix with Budgie Desktop Environment
#
# Maintainer(s):
# - Aris Ripandi      <ripandi@pm.me>

# Budgie Repo by Alunux
repo --name="Budgie Desktop Stable by alunux" --baseurl=https://copr-be.cloud.fedoraproject.org/results/alunux/budgie-desktop-stable/fedora-$releasever-$basearch/ --cost=1000

%include remix-live-base.ks
%include remix-live-cleanup.ks
%include remix-budgie-packages.ks

%post

sed -i "s|\("^Out" * *\).*|\1\${HOME}/Documents|" /etc/cups/cups-pdf.conf

#cat > /etc/sysconfig/desktop <<EOF
#PREFERRED=/usr/bin/startx
#DISPLAYMANAGER=/usr/sbin/lightdm
#EOF

cat >> /etc/rc.d/init.d/livesys << EOF

# mkdir -p /home/liveuser/.config/xfce4

# disable screensaver locking (#674410)
cat >> /home/liveuser/.xscreensaver << FOE
mode:           off
lock:           False
dpmsEnabled:    False
FOE

# deactivate budgie-screensaver
rm -f /etc/xdg/autostart/budgie-desktop-screensaver.desktop || :

# set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf

# set Budgie as default session, otherwise login will fail
# sed -i 's/^#user-session=.*/user-session=budgie/' /etc/lightdm/lightdm.conf

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
