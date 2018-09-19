#
# Repository List
#
# part of Poliba Corse OS
#

#
# Fedora Official Repos
#
repo --name=fedora --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch

repo --name=updates --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f$releasever&arch=$basearch

url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch

#
# RPMFusion
#
repo --name="RPMFusion Free" --baseurl=https://mirror.netsite.dk/rpmfusion/free/fedora/development/27/Everything/x86_64/os

repo --name="RPMFusion Nonfree" --baseurl=https://mirror.netsite.dk/rpmfusion/nonfree/fedora/development/27/Everything/x86_64/os

#
# COPRs
#
repo --name=polibacorse --baseurl=https://copr-be.cloud.fedoraproject.org/results/corsaro/PolibaCorse-OS/fedora-$releasever-$basearch --install

repo --name=numix --baseurl=https://copr-be.cloud.fedoraproject.org/results/numix/numix/fedora-26-$basearch --install

repo --name=themes --baseurl https://copr-be.cloud.fedoraproject.org/results/tcg/themes/fedora-$releasever-$basearch --install
