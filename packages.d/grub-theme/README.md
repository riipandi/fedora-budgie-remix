# grub2-solarium
Grub2 theme based in StylishDark

![Alt text](https://raw.githubusercontent.com/ripandi/grub2-solarium/master/screenshot.png "Screenshot")

 How To:
======

 1. Unzip
 2. Go to unzipped folder
 3. in terminal run the command **`sudo ./install.sh`**
 4. Follow the messages
 5. Reboot && Enjoy :)

or u can do this manually:
----

 1. Unzip and copy theme folder in **`/boot/grub2/themes/`**
 2. add (or edit existing lines) this to **`/etc/default/grub`**:

 `GRUB_THEME=/boot/grub2/themes/grub2-solarium/theme.txt`

 3. update your grub:
   1. for Fedora `grub2-mkconfig -o /boot/grub2/grub.cfg`
UEFI
`grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg`

   2. for Debian `update-grub`
4. Done!