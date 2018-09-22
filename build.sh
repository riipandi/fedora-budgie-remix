#!/bin/bash

VERSION="28"
FSLABEL="fedora-budgie-remix"
ISOFILE="f$VERSION-budgie-x64"

if [[ $EUID -ne 0 ]]; then echo -e 'This script must be run as root' ; exit 1 ; fi

if ! rpm -q --quiet livecd-tools ; then
  dnf -y install kernel-modules-$(uname -r) livecd-tools pungi \
   {fedora,spin,l10n}-kickstarts pykickstart
fi

pwddir=$(dirname "$(readlink -f "$0")")

ksflatten \
 --config $pwddir/kickstart.d/remix-budgie-live.ks \
 -o $pwddir/remix-budgie.ks --version F$VERSION

livecd-creator -c remix-budgie.ks \
 --title="Fedora Budgie Remix" \
 --cache=/var/cache/live \
 --logfile=livebuild.log \
 --fslabel=$FSLABEL \
 --releasever=$VERSION \
 --verbose

mv $FSLABEL.iso $ISOFILE.iso
sha1sum $ISOFILE.iso > $ISOFILE.sum
