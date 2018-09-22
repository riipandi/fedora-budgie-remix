repo --name="Etcher Electron" --baseurl=https://resin-io.bintray.com/redhat --cost=1000
repo --name="Negativo Spotify" --baseurl=https://negativo17.org/repos/spotify/fedora-$releasever/$basearch/ --cost=1000
repo --name="Visual Studio Code" --baseurl=https://packages.microsoft.com/yumrepos/vscode --cost=1000

%packages

audacious
audacity
filezilla
geary
telegram-desktop
etcher-electron
spotify-client
code

%end
