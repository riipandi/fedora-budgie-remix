# https://fedoraproject.org/wiki/Remix
# https://fedoraproject.org/wiki/Talk:How_to_create_and_use_a_Live_CD
# https://fedoraproject.org/wiki/Livemedia-creator-_How_to_create_and_use_a_Live_CD
# https://docs.fedoraproject.org/f28/install-guide/appendixes/Kickstart_Syntax_Reference.html
# https://wiki.sugarlabs.org/go/Build_Your_Own_Remix_with_Fedora
# https://opensourceforu.com/2010/01/roll-out-a-fedora-remix/
# http://weldr.io/lorax/livemedia-creator.html

# Set selinux mode to permissive
perl -pi -e 's#(SELINUX=)(.*)#${1}permissive#' /etc/selinux/config

# Install the toolchain
dnf -y install kernel-modules-$(uname -r) mock curl livecd-tools pungi \
 {fedora,spin,l10n}-kickstarts pykickstart anaconda lorax virt-install \
  libvirt-daemon-config-network

usermod -a -G mock ariss

# Get kickstarts
git clone https://pagure.io/fedora-kickstarts.git fedora-ks -b f28

# Init Environment: run as general user
mock -r fedora-28-x86_64 --init
mock -r fedora-28-x86_64 --install lorax-lmc-novirt vim-minimal pykickstart

# Running a Compose
mock -r fedora-28-x86_64 --shell --old-chroot

# Chroot: Flatten a Kickstart
rm fedora-xfce.ks  ; ksflatten --config fedora-ks/fedora-live-xfce.ks -o fedora-xfce.ks --version F28
rm ertix-budgie.ks ; ksflatten --config budgie-ks/main.ks -o ertix-budgie.ks --version F28

# Chroot: Create the Live Image
rm -fr /var/livebuild ; mkdir -p /tmp/livebuild
livemedia-creator \
 --ks ertix-budgie.ks \
 --logfile /tmp/livebuild.log \
 --tmp /tmp/livebuild \
 --resultdir /var/livebuild \
 --project "Fedora Budgie Remix"  \
 --volid "Fedora Budgie Remix x64" \
 --title "Fedora Budgie Remix" \
 --make-iso --iso-only --releasever 28 \
 --iso-name fedora-budgie-live.iso \
 --no-virt --macboot

# Compose Results and cleanup
cp /var/lib/mock/fedora-27-x86_64/root/var/lmc/*.iso $HOME
mock -r fedora-27-x86_64 --clean

# Old method
mkdir -p kickstart.d ; cd kickstart.d
curl -sLO https://pagure.io/fedora-kickstarts/raw/f28/f/fedora-repo.ks
curl -sLO https://pagure.io/fedora-kickstarts/raw/f28/f/fedora-live-base.ks
curl -sLO https://pagure.io/fedora-kickstarts/raw/f28/f/fedora-live-minimization.ks
curl -sLO https://pagure.io/fedora-kickstarts/raw/f28/f/fedora-repo-not-rawhide.ks
curl -sLO https://pagure.io/fedora-kickstarts/raw/f28/f/fedora-repo-rawhide.ks
curl -sLO https://pagure.io/fedora-kickstarts/raw/f28/f/fedora-xfce-common.ks
curl -sLO https://pagure.io/fedora-kickstarts/raw/f28/f/fedora-live-xfce.ks

mv fedora-live-xfce.ks remix-live-budgie.ks
mv fedora-xfce-common.ks remix-budgie-common.ks

# In the %post section of the kickstart file, add the following as the first line:
# sed -i -e ‘s/Generic release/Budgie Fedora Remix/g’ /etc/fedora-release /etc/issue
