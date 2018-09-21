# https://fedoraproject.org/wiki/Remix
# https://fedoraproject.org/wiki/Talk:How_to_create_and_use_a_Live_CD
# https://fedoraproject.org/wiki/Livemedia-creator-_How_to_create_and_use_a_Live_CD
# https://docs.fedoraproject.org/f28/install-guide/appendixes/Kickstart_Syntax_Reference.html
# https://wiki.sugarlabs.org/go/Build_Your_Own_Remix_with_Fedora
# https://opensourceforu.com/2010/01/roll-out-a-fedora-remix/
# http://weldr.io/lorax/livemedia-creator.html

# Install the toolchain
dnf -y install kernel-modules-$(uname -r) mock curl livecd-tools pungi \
 {fedora,spin,l10n}-kickstarts pykickstart anaconda lorax virt-install \
  libvirt-daemon-config-network lorax virt-install appliance-tools

systemctl restart libvirtd
usermod -a -G mock ariss

# Set selinux mode to permissive
perl -pi -e 's#(SELINUX=)(.*)#${1}permissive#' /etc/selinux/config

# Get kickstarts
git clone https://pagure.io/fedora-kickstarts.git fedora-ks -b f28

# Init Environment: run as general user
mock -r fedora-28-x86_64 --init
mock -r fedora-28-x86_64 --install lorax-lmc-novirt vim-minimal pykickstart git

# Running a Compose
mock -r fedora-28-x86_64 --shell --old-chroot

# Chroot: Flatten a Kickstart
cd /usr/src; git clone https://github.com/riipandi/fedora-budgie-remix.git fbr
ksflatten --config fbr/kickstart.d/ertix-live-budgie.ks -o ertix-budgie.ks --version F28

# Chroot: Create the Live Image
rm -fr /var/livebuild ; mkdir -p /tmp/livebuild
livemedia-creator \
 --ks ertix-budgie.ks \
 --logfile /tmp/livebuild.log \
 --project "Fedora Budgie Remix"  \
 --volid "Fedora Budgie Remix x64" \
 --title "Fedora Budgie Remix" \
 --make-iso --iso-only --releasever 28 \
 --iso-name fedora-budgie-live.iso \
 --no-virt --macboot

# Compose Results and cleanup
cp /var/lib/mock/fedora-28-x86_64/root/var/lmc/*.iso $HOME
mock -r fedora-28-x86_64 --clean

# Old method
mkdir -p f28 ; cd $_
curl -sLO https://pagure.io/fedora-kickstarts/raw/f28/f/fedora-arm-base.ks
curl -sLO https://pagure.io/fedora-kickstarts/raw/f28/f/fedora-arm-xbase.ks
curl -sLO https://pagure.io/fedora-kickstarts/raw/f28/f/fedora-arm-xfce.ks
curl -sLO https://pagure.io/fedora-kickstarts/raw/f28/f/fedora-live-base.ks
curl -sLO https://pagure.io/fedora-kickstarts/raw/f28/f/fedora-live-minimization.ks
curl -sLO https://pagure.io/fedora-kickstarts/raw/f28/f/fedora-live-xfce.ks
curl -sLO https://pagure.io/fedora-kickstarts/raw/f28/f/fedora-xfce-common.ks
curl -sLO https://pagure.io/fedora-kickstarts/raw/f28/f/fedora-repo-not-rawhide.ks
mv fedora-repo-not-rawhide.ks fedora-repo.ks

ksflatten --config kickstart.d/remix-budgie-live.ks -o remix-budgie.ks --version F28
livecd-creator --cache=/var/cache/live --config=remix-budgie.ks --fslabel=budgie-remix

rm -f /usr/share/glib-2.0/schemas/10_org.gnome.desktop.background.fedora.gschema.override
rm -f /usr/share/glib-2.0/schemas/10_org.gnome.desktop.screensaver.fedora.gschema.override

cat > /usr/share/glib-2.0/schemas/10_org.gnome.desktop.gschema.override <<EOF
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
EOF

cat > /usr/share/glib-2.0/schemas/10_com.solus-project.gschema.override <<EOF
[com.solus-project.budgie-panel]
migration-level=1
panels=['de697aa0-bd86-11e8-a4e0-b0c0903cd2bd']

[com.solus-project.budgie-panel.panel]
location='bottom'
transparency='none'
size=36

[com.solus-project.icon-tasklist]
pinned-launchers=['com.gexperts.Tilix.desktop', 'org.gnome.Nautilus.desktop', 'chromium-browser.desktop']

[com.solus-project.budgie-wm]
button-layout='appmenu:minimize,maximize,close'
EOF

useradd -mg wheel -s `which bash` bela -c "Nabila Azmi" -p `openssl passwd -1 "azmi"`