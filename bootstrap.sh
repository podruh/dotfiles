#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	echo ----------- Installing zsh...
	sudo apt install zsh
	echo ----------- Installing zsh prezto...
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

 	echo ----------- Installing  PowerLevel9k theme...
	git clone https://github.com/bhilburn/powerlevel9k.git  ~/.zprezto/modules/prompt/external/powerlevel9k
	ln -fs ~/.zprezto/modules/prompt/external/powerlevel9k/powerlevel9k.zsh-theme ~/.zprezto/modules/prompt/functions/prompt_powerlevel9k_setup
	echo ----------- Installing rbenv ...
	curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
	git clone https://github.com/ianheggie/rbenv-binstubs.git "~/.rbenv/plugins/rbenv-binstubs"
	echo ----------- Installing git-standup ...
	curl -L https://raw.githubusercontent.com/kamranahmedse/git-standup/master/installer.sh | sudo sh
	echo ----------- Installing postgres, redis, i3 ...
	sudo add-apt-repository ppa:kgilmer/speed-ricer
	sudo apt-get update
	sudo apt install postgresql postgresql-contrib redis-server compton i3-gaps-wm
	echo ----------- Setting pg user ...
	sudo -u postgres createuser  $USERNAME -s
	sudo chsh -s $(which zsh)
	echo ----------- Installing stow...
	sudo apt install stow
	stow bash \
		compton \
		git \
		i3 \
		zsh
	echo Install powerline font https://github.com/bhilburn/powerlevel9k/wiki/Install-Instructions#step-2-install-a-powerline-font
	echo Edit /etc/redis/redis.conf and add "supervised systemd" then run "sudo systemctl restart redis.service"
	echo Reboot machine for changes to take place
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
