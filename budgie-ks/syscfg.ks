#
# System Configuration
#
# part of Poliba Corse OS
#

firewall --enabled --service=mdns
auth --useshadow --passalgo=sha512
rootpw --lock --iscrypted locked
selinux --enforcing
# should add ModemManager in services?
services --enabled=NetworkManager
network --bootproto=dhcp --device=link --activate
xconfig --startxonboot
reboot
