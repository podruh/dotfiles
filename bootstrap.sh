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
	ln -s ~/.zprezto/modules/prompt/external/powerlevel9k/powerlevel9k.zsh-theme ~/.zprezto/modules/prompt/functions/prompt_powerlevel9k_setup

	echo ----------- Install powerline font https://github.com/bhilburn/powerlevel9k/wiki/Install-Instructions#step-2-install-a-powerline-font
	echo ----------- Installing RVM ...
	sudo apt-add-repository -y ppa:rael-gc/rvm
	sudo apt-get update
	sudo apt-get install rvm
	echo ----------- Installing git-standup ...
	curl -L https://raw.githubusercontent.com/kamranahmedse/git-standup/master/installer.sh | sudo sh
	sudo chsh -s $(which zsh)

	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		--exclude "brew.sh" \
		--exclude ".bash_profile" \
		--exclude ".bash_prompt" \
		--exclude ".bashrc" \
		-avh --no-perms . ~;
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
