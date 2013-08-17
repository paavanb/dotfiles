#!/bin/bash
cd "$(dirname "$0")"
function updateHomeDir() {
	rsync --exclude ".git/" --exclude ".gitignore" --exclude ".gitmodules" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av . ~
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	updateHomeDir
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		updateHomeDir
	fi
fi
unset updateHomeDir
