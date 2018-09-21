# remix-repo-base.ks
#
# Description:
# - Fedora Remix with Budgie Desktop Environment
#
# Maintainer(s):
# - Aris Ripandi      <ripandi@pm.me>

# Fedora
repo --name="Fedora" --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch
repo --name="Fedora Updates" --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f$releasever&arch=$basearch
url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch

# RPMFusion
repo --name="RPM Fusion Free" --baseurl=http://download1.rpmfusion.org/free/fedora/releases/$releasever/Everything/$basearch/os --cost=1000
repo --name="RPM Fusion Free - Updates" --baseurl=http://download1.rpmfusion.org/free/fedora/updates/$releasever/$basearch --cost=1000
repo --name="RPM Fusion Non-Free" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/releases/$releasever/Everything/$basearch/os --cost=1000
repo --name="RPM Fusion Non-Free - Updates" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/updates/$releasever/$basearch --cost=1000
