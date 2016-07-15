#!/bin/bash

# run like this:
# sudo env PATH=/home/$(whoami)/bin:$PATH /bin/bash -x aptgets.sh
# Some inspiration:
# https://setting-ubuntu-up.googlecode.com/svn/trunk/main.sh
# http://www.binarytides.com/better-linux-mint-17-cinnamon/
# http://www.binarytides.com/install-nvidia-drivers-linux-mint-16/

# exit immediately if something fails
set -o nounset
set -o errexit

setupSources() {
  serv='br.'
  RELEASE=$(lsb_release -sc)

  if [ "$(lsb_release -si)" == 'LinuxMint' ]; then
    RELEASE="trusty"
  else # for ubuntu
    # main, universe, restricted and multiverse with sources
    add-apt-repository -s -y "deb http://${serv}archive.ubuntu.com/ubuntu $RELEASE main universe restricted multiverse"
    # main, universe, restricted and multiverse security
    add-apt-repository -s -y "deb http://${serv}archive.ubuntu.com/ubuntu $RELEASE-security main universe restricted multiverse"
  fi
  # Partner REPOSITORY
  add-apt-repository -y "deb http://archive.canonical.com/ubuntu $RELEASE partner"
  add-apt-repository -y "deb http://archive.getdeb.net/ubuntu xenial-getdeb apps"

  ## PPAs
  add-apt-repository -y ppa:webupd8team/java
  add-apt-repository -y ppa:webupd8team/themes
  add-apt-repository -y ppa:ubuntu-wine/ppa
  #add-apt-repository -y ppa:lestcape/cinnamon
  add-apt-repository -y ppa:linrunner/tlp #tlp tlp-rdw battery
  add-apt-repository -y ppa:libreoffice/libreoffice-4-3
  add-apt-repository -y ppa:yorba/ppa #shotwell
  add-apt-repository -y ppa:pi-rho/dev #tmux 2.x
  add-apt-repository -y ppa:neovim-ppa/unstable # neovim
  add-apt-repository -y ppa:keepassx/daily #keepassx

  ## ===== Google chrome =====
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  add-apt-repository -y "deb http://dl.google.com/linux/chrome/deb/ stable main"
  add-apt-repository -y "deb http://dl.google.com/linux/musicmanager/deb/ stable main"
  add-apt-repository -y "deb http://dl.google.com/linux/talkplugin/deb/ stable main"
  ## ===== ======
}

setupSources
apt-get update

#debdir=$1;
#if [ -z "$1" ]; then
	#debdir="";
#fi;

#cp $debdir*.deb /var/cache/apt/archives/
#dpkg -i $debdir*.deb

install_items="
# backup and utils
fortune duply getmail4
# terminal/ide tools
git-core git-svn tig zsh curl tmux neovim vim vim-gtk ncurses-term ack-grep xclip gawk silversearcher-ag
# File system tools
nfs-common ssh sshfs sshguard samba smbclient gparted ntfs-3g ntfs-config ssmtp
# systemtools
preload powertop libqt4-gui module-assistant po-debconf dkms iotop whois hardinfo ncdu sshuttle
# languages
language-pack-en language-pack-pt
# compressors
unace p7zip-rar sharutils rar arj lunzip lzip unrar zip unzip p7zip-full kgb sharutils uudeview mpack file-roller
# latex
# texlive texlive-lang-portuguese dvipng abntex texlive-publishers tex4ht rubber texlive-science
# gedit-latex-plugin texlive-fonts-recommended latex-beamer texpower texlive-pictures texlive-latex-extra texpower-examples imagemagick
# media
vlc audacity easytag banshee beets
# messengers
pidgin-encryption pidgin-extprefs pidgin-libnotify pidgin-mpris pidgin-otr pidgin-plugin-pack pidgin-privacy-please
# restricted
flashplugin-installer ubuntu-restricted-addons ubuntu-restricted-extras
# codecs, not sure if these are needed
libxine1-ffmpeg mencoder flac faac faad sox ffmpeg2theora libmpeg2-4 uudeview libmpeg3-1 mpeg3-utils mpegdemux liba52-dev mpeg2dec vorbis-tools id3v2 mpg321 mpg123 libflac++6 totem-mozilla icedax lame libmad0 libjpeg-progs libdvdread4 libdvdnav4 libswscale-extra-2
libxine1-plugins mjpegtools mp3gain regionset ca-certificates-java
# visual
#compiz-fusion-bcop compiz-plugins compizconfig-settings-manager fusion-icon
cinnamon unity-tweak-tool gnome-tweak-tool
# nautilus tools
# nautilus-script-audio-convert nautilus-filename-repairer nautilus-image-converter nautilus-open-terminal nautilus-sendto nautilus-share nautilus-dropbox 
dropbox python-gpgme
# gnome acessories
quicksynergy links gimp dia-gnome cheese conky brasero gnome-activity-journal pinta calibre shutter guake gnucash libappindicator1 backintime-gnome terminator
#wicd finch gnome-do nautilus-gksu
# compiler tools
dh-make build-essential hardinfo automake autoconf autotools-dev libtool gcc
# python
python-dev python-pip python3-dev python3-pip python-pp python-setuptools python-sqlite
# programing others
ruby meld virtualbox sqlite3 
# not used: rapidsvn geany geany-plugins qtcreator codeblocks valgrind
# ppas
wine winetricks skype google-chrome-stable google-talkplugin google-musicmanager-beta faenza-icon-theme tlp tlp-rdw
shotwell
oracle-jdk7-installer oracle-java7-installer
# new
gtypist keepass2 keepassx xmonad libreoffice

"

opts=""

aptbin="apt-get"
echo "PATH is configured as follows: $PATH"
if hash apt-fast 2>/dev/null; then
  echo "Using apt-fast..."
  aptbin="apt-fast"
  if ! hash aria2c 2>/dev/null; then
    apt-get install -y aria2
  fi
fi

all_items=$(echo "$install_items" | grep -v '^$\|^\s*\#' | tr '\n' ' ')
echo "Will install the following packages: $all_items"

sleep 2
$aptbin -y -mf${opts} install $all_items

$aptbin -y upgrade

# clean up everything
apt-get -y purge evolution openjdk-6-jre openjdk-6-jdk texlive-latex-extra-doc texlive-pstricks-doc texlive-latex-base-doc openjdk-6-jre-headless freepats unity-webapps-common
apt-get -y autoremove
#apt-get -y autoclean


#rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# edit and add: /etc/sysctl.conf
# # Increase size of file handles and inode cache
# fs.file-max = 2097152
# 
# # Do less swapping
# vm.swappiness = 10
# vm.dirty_ratio = 60
# vm.dirty_background_ratio = 2
# vm.vfs_cache_pressure=50 ??
# fs.inotify.max_user_watches=100000
# echo fs.inotify.max_user_watches=100000 | sudo tee -a /etc/sysctl.conf; sudo sysctl -p
# More here: https://rtcamp.com/tutorials/linux/sysctl-conf/
# And: https://askubuntu.com/questions/2194/how-can-i-improve-ubuntu-overall-system-performance

exit 0