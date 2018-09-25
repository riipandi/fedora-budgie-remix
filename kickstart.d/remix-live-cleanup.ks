# remix-budgie-packages.ks
#
# Description:
# - Fedora Remix with Budgie Desktop Environment
#
# Maintainer(s):
# - Aris Ripandi      <ripandi@pm.me>


%packages

# save some space
-mpage
-sox
-hplip
-numactl
-isdn4k-utils
-autofs
# smartcards won't really work on the livecd.
-coolkey

# scanning takes quite a bit of space :/
-xsane
-xsane-gimp
-sane-backends

%end
