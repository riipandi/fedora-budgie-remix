# https://fedoraproject.org/wiki/Remix
# https://fedoraproject.org/wiki/Talk:How_to_create_and_use_a_Live_CD
# https://fedoraproject.org/wiki/Livemedia-creator-_How_to_create_and_use_a_Live_CD
# https://docs.fedoraproject.org/f28/install-guide/appendixes/Kickstart_Syntax_Reference.html
# https://wiki.sugarlabs.org/go/Build_Your_Own_Remix_with_Fedora
# https://opensourceforu.com/2010/01/roll-out-a-fedora-remix/

# Set selinux mode to permissive
perl -pi -e 's#(SELINUX=)(.*)#${1}permissive#' /etc/selinux/config

# Install the toolchain
dnf -y install curl livecd-tools pungi {fedora,spin,l10n}-kickstarts

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

rm -fr /var/cache/live
livecd-creator --cache=/var/cache/live --config=ertix-live-budgie.ks --fslabel=budgie-remix

livemedia-creator \
 --ks kickstart.d/remix-live-budgie.ks \
 --logfile /tmp/livemedia-out.log \
 --no-virt --resultdir /tmp/livebuild \
 --project Fedora-soas-Live --make-iso \
 --volid Fedora-SoaS-flat-live \
 --iso-only --iso-name Fedora-SoaS-flat-live.iso \
 --releasever 24 \
 --title Fedora-SoaS-flat-live \
 --macboot
