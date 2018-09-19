#
# System Customisation
#
# part of Poliba Corse OS
#

%post

# Graphical Customisations
cat >> /usr/share/glib-2.0/schemas/custom.gschema.override << EOF
[org.gnome.desktop.interface]
gtk-theme='Arc-Dark'
icon-theme='Numix'
cursor-theme='La Capitaine'

[org.gnome.desktop.background]
picture-uri='file:///usr/share/backgrounds/polibacorse-os/pc5-16k.jpg'

[org.gnome.desktop.screensaver]
picture-uri='file:///usr/share/backgrounds/polibacorse-os/pc5-16k.jpg'

[org.gnome.desktop.input-sources]
sources=[('xkb','it')]

[org.gnome.shell]
favorite-apps=['chromium-browser.desktop', 'org.gnome.Nautilus.desktop', 'org.qt-project.qtcreator.desktop', 'telegram-desktop.desktop']

[org.gnome.settings-daemon.plugins.xsettings]
antialiasing='rgba'
hinting='slight'
EOF

# Set Dark theme
mkdir -p /etc/gtk-3.0/
cat > /etc/gtk-3.0/settings.ini << EOF
[Settings]
gtk-application-prefer-dark-theme=1
EOF

# rebuild schema cache with any overrides installed
glib-compile-schemas /usr/share/glib-2.0/schemas

%end
