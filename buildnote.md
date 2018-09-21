# Build Notes

## References

- <https://fedoraproject.org/wiki/Remix>
- <https://fedoraproject.org/wiki/Talk:How_to_create_and_use_a_Live_CD>
- <https://fedoraproject.org/wiki/Livemedia-creator-_How_to_create_and_use_a_Live_CD>
- <https://docs.fedoraproject.org/f28/install-guide/appendixes/Kickstart_Syntax_Reference.html>
- <https://wiki.sugarlabs.org/go/Build_Your_Own_Remix_with_Fedora>
- <https://opensourceforu.com/2010/01/roll-out-a-fedora-remix/>
- <http://weldr.io/lorax/livemedia-creator.html>

## Dependencies

```bash
dnf -y install kernel-modules-$(uname -r) mock curl livecd-tools pungi \
 {fedora,spin,l10n}-kickstarts pykickstart anaconda lorax virt-install \
  libvirt-daemon-config-network lorax virt-install appliance-tools
```

```bash
sudo usermod -a -G mock yourname
sudo systemctl enable --now libvirtd
```

**Set selinux mode to permissive**

```bash
sudo setenforce 0
```

## Get Fedora kickstarts

```bash
git clone https://pagure.io/fedora-kickstarts.git fedora-ks -b f28
```

## Init Environment: run as general user

```bash
mock -r fedora-28-x86_64 --init
mock -r fedora-28-x86_64 --install lorax-lmc-novirt vim-minimal pykickstart git
```

## Running a Compose

```bash
mock -r fedora-28-x86_64 --shell --old-chroot
```

## Chroot: Flatten a Kickstart

```bash
cd /usr/src; git clone https://github.com/riipandi/fedora-budgie-remix.git fbr
ksflatten --config fbr/kickstart.d/remix-live-budgie.ks -o remix-budgie.ks --version F28
```

## Chroot: Create the Live Image

```bash
rm -fr /var/livebuild
mkdir -p /tmp/livebuild

livemedia-creator \
 --ks remix-budgie.ks \
 --logfile /tmp/livebuild.log \
 --project "Fedora Budgie Remix"  \
 --volid "Fedora Budgie Remix x64" \
 --title "Fedora Budgie Remix" \
 --make-iso --iso-only --releasever 28 \
 --iso-name fedora-budgie-live.iso \
 --no-virt --macboot
```

## Compose Results and cleanup

```bash
cp /var/lib/mock/fedora-28-x86_64/root/var/lmc/*.iso $HOME
mock -r fedora-28-x86_64 --clean
```

## Old method

```bash
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
```