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

rm -f /usr/share/glib-2.0/schemas/10_org.gnome.desktop.background.fedora.gschema.override
rm -f /usr/share/glib-2.0/schemas/10_org.gnome.desktop.screensaver.fedora.gschema.override

# sed -i "s|\("^Out" * *\).*|\1\${HOME}/Documents|" /etc/cups/cups-pdf.conf

cat >> /etc/rc.d/init.d/livesys << EOF

# disable gnome-software automatically downloading updates
cat >> /usr/share/glib-2.0/schemas/org.gnome.software.gschema.override << FOE
[org.gnome.software]
download-updates=false
FOE

# don't autostart gnome-software session service
rm -f /etc/xdg/autostart/gnome-software-service.desktop

# deactivate budgie-screensaver
rm -f /etc/xdg/autostart/budgie-desktop-screensaver.desktop || :

# set Budgie as default session, otherwise login will fail
# sed -i 's/^#user-session=.*/user-session=budgie/' /etc/lightdm/lightdm.conf

# Budgie customization
cat > /usr/share/glib-2.0/schemas/10_org.gnome.desktop.gschema.override <<FOE
[org.gnome.desktop.background]
picture-uri = 'file:///usr/share/backgrounds/fedora-workstation/paisaje.jpg'

[org.gnome.desktop.screensaver]
picture-uri = 'file:///usr/share/backgrounds/f28/default/f28.xml'

[org.gnome.desktop.interface]
gtk-theme = 'Arc-Darker'
icon-theme = 'Pop'
cursor-theme = 'Pop'
font-name = 'Fira Sans Book 10'
document-font-name = 'Roboto Slab Regular 11'
monospace-font-name = 'Fira Mono Regular 11'

[org.gnome.desktop.wm.preferences]
theme = 'Pop'
titlebar-font = 'Fira Sans SemiBold 10'
FOE

cat > /usr/share/glib-2.0/schemas/10_com.solus-project.gschema.override <<FOE
[com.solus-project.budgie-panel]
migration-level=1

[com.solus-project.budgie-panel.panel]
location='bottom'
transparency='none'
size=36

[com.solus-project.icon-tasklist]
pinned-launchers=['com.gexperts.Tilix.desktop', 'org.gnome.Nautilus.desktop', 'chromium-browser.desktop']

[com.solus-project.budgie-wm]
button-layout='appmenu:minimize,maximize,close'
FOE

# Rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

# set up auto-login
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

%end
