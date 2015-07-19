#!/bin/bash

# exit immediately if something fails
set -o nounset
set -o errexit

#srcs='/etc/apt/sources.list'
#put_sources(){ echo -e "$2" > /tmp/$srcs.d/$1-$release.list; }
serv='br.'
release=$(lsb_release -sc)
#put_sources "ubuntu-repos" ""
# adds main, universe, restricted and multiverse with sources
add-apt-repository -s -y "deb http://${serv}archive.ubuntu.com/ubuntu $release main universe restricted multiverse"
# adds main, universe, restricted and multiverse security
add-apt-repository -s -y "deb http://${serv}archive.ubuntu.com/ubuntu $release-security main universe restricted multiverse"
# Partner REPOSITORY
add-apt-repository -y "deb http://archive.canonical.com/ubuntu $release partner"

## PPAs
add-apt-repository -y ppa:webupd8team/java
add-apt-repository -y ppa:webupd8team/themes
add-apt-repository -y ppa:ubuntu-wine/ppa
add-apt-repository -y ppa:lestcape/cinnamon
add-apt-repository -y ppa:linrunner/tlp #tlp tlp-rdw battery
add-apt-repository -y ppa:libreoffice/libreoffice-4-3
add-apt-repository -y ppa:yorba/ppa #shotwell


## ===== Virtual box =====
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add - && \
echo "deb http://download.virtualbox.org/virtualbox/debian $release contrib" > /etc/apt/sources.list.d/virtualbox.list

## ===== Google chrome =====
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -  && \
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
echo "deb http://dl.google.com/linux/musicmanager/deb/ stable main" > /etc/apt/sources.list.d/google-musicmanager.list
## ===== ======

debs="
https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb
http://www.skype.com/go/getskype-linux-deb
https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.6.2_amd64.deb
"

#debdir=$1;
#if [ -z "$1" ]; then
	#debdir="";
#fi;

#cp $debdir*.deb /var/cache/apt/archives/
#dpkg -i $debdir*.deb

install_items="
# languages
language-pack-en language-pack-pt
# language-pack-de
# compressors
rar unrar zip unzip p7zip-full p7zip-rar arj kgb sharutils uudeview mpack file-roller unace
# latex
# texlive texlive-lang-portuguese dvipng abntex texlive-publishers tex4ht rubber texlive-science
# gedit-latex-plugin texlive-fonts-recommended latex-beamer texpower texlive-pictures texlive-latex-extra texpower-examples imagemagick
# media
vlc audacity easytag banshee beets
# messengers
pidgin-encryption pidgin-extprefs pidgin-libnotify pidgin-mpris pidgin-otr pidgin-plugin-pack pidgin-privacy-please
# restricted
flashplugin-installer ubuntu-restricted-addons ubuntu-restricted-extras
# codecs
libxine1-ffmpeg mencoder flac faac faad sox ffmpeg2theora libmpeg2-4 uudeview libmpeg3-1 mpeg3-utils mpegdemux liba52-dev mpeg2dec vorbis-tools id3v2 mpg321 mpg123 libflac++6 totem-mozilla icedax lame libmad0 libjpeg-progs libdvdread4 libdvdnav4 libswscale-extra-2
libxine1-plugins mjpegtools mp3gain regionset ca-certificates-java
# visual
#compiz-fusion-bcop compiz-plugins compizconfig-settings-manager fusion-icon
cinnamon unity-tweak-tool gnome-tweak-tool
# nautilus tools
# nautilus-script-audio-convert nautilus-filename-repairer nautilus-image-converter nautilus-open-terminal nautilus-sendto nautilus-share
nautilus-dropbox
# gnome acessories
quicksynergy links gedit-plugins gimp dia-gnome cheese conky brasero gnome-activity-journal pinta gnome-tweak-tool calibre shutter guake gnucash libappindicator1 backintime-gnome
#google-talkplugin wicd finch gnome-do nautilus-gksu
# File system tools
nfs-common ssh sshfs sshguard samba smbclient gparted ntfs-3g ntfs-config ssmtp
# systemtools
preload powertop bootchart libqt4-gui module-assistant po-debconf dkms iotop getmail4 whois
# compiling tools
dh-make build-essential hardinfo automake autoconf autotools-dev libtool
# terminal/ide tools
git-core git-svn zsh curl tmux vim ack-grep xclip gawk fortune duply
# programming
meld rapidsvn python-sqlite python-setuptools sqlite3 geany geany-plugins qtcreator codeblocks valgrind gcc python-pp python-pip ruby
# ppas
wine winetricks skype google-chrome-beta faenza-icon-theme tlp tlp-rdw virtualbox-4.3
# shotwell
oracle-jdk7-installer oracle-java7-installer
# new
gtypist keepass2 keepassx xmonad libreoffice

"

opts=""

aptbin="apt-get"
if hash apt-fast 2>/dev/null; then
  echo "Using apt-fast..."
  aptbin="apt-fast"
fi
$aptbin update

all_items=$(echo "$install_items" | grep -v '^$\|^\s*\#' | tr '\n' ' ')
echo "Will install the following packages: $all_items"

sleep 1
$aptbin -y -mf${opts} install "$all_items"


$aptbin -y upgrade

# clean up everything
apt-get -y purge evolution openjdk-6-jre openjdk-6-jdk texlive-latex-extra-doc texlive-pstricks-doc texlive-latex-base-doc openjdk-6-jre-headless freepats unity-webapps-common
apt-get -y autoremove
#apt-get -y autoclean


rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
exit 0