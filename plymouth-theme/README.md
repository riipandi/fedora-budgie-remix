#darwin
This is plymouth theme for Fedora Linux



#Screenshot

![Alt text](https://raw.githubusercontent.com/ripandi/darwin/master/screenshot.png "Screenshot")



##Installing
tested only on Fedora 23 64bit

* Install deps
  * ```sudo dnf install plymouth-theme-script git```

* clone repo
  * ```cd ~/Downloads && git clone https://github.com/yucefsourani/arfedora-plymouth-theme.git```

* move theme folder to /usr/share/plymouth/themes
  * ```sudo mv  ~/Downloads/arfedora-plymouth-theme/darwin /usr/share/plymouth/themes/darwin```

* set theme
  * ```sudo plymouth-set-default-theme darwin -R```

* rebuild initramfs
  * ```sudo dracut --force```

* remove arfedora-plymouth-theme folder
  * ```sudo rm -r ~/Downloads/arfedora-plymouth-theme```



##Based on

darwin plymouth theme
http://gnome-look.org/content/show.php/Darwin+Plymouth?content=170649



##arfedora blog

http://arfedora.blogspot.com/



##LICENSE

GPL


