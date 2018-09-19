#
# Repository List
#
# part of Poliba Corse OS
#

# Fedora Official Repos
repo --name="Fedora - x86_64" --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch
repo --name="Fedora - x86_64 - Updates" --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f$releasever&arch=$basearch
url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch

# RPMFusion
repo --name="RPM Fusion Free" --baseurl=http://download1.rpmfusion.org/free/fedora/releases/$releasever/Everything/$basearch/os --cost=1000
repo --name="RPM Fusion Free - Updates" --baseurl=http://download1.rpmfusion.org/free/fedora/updates/$releasever/$basearch --cost=1000
repo --name="RPM Fusion Non-Free" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/releases/$releasever/Everything/$basearch/os --cost=1000
repo --name="RPM Fusion Non-Free - Updates" --baseurl=http://download1.rpmfusion.org/nonfree/fedora/updates/$releasever/$basearch --cost=1000

# COPRs
repo --name=polibacorse --baseurl=https://copr-be.cloud.fedoraproject.org/results/corsaro/PolibaCorse-OS/fedora-$releasever-$basearch --install
repo --name=numix --baseurl=https://copr-be.cloud.fedoraproject.org/results/numix/numix/fedora-$releasever-$basearch --install
repo --name=themes --baseurl https://copr-be.cloud.fedoraproject.org/results/tcg/themes/fedora-$releasever-$basearch --install
