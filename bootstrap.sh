#!/bin/bash
cd "$(dirname "$0")"
git pull
function updateHomeDir() {
	rsync --exclude-from './exclude_files.txt' -av . ~
    vim +BundleInstall +qall
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
unset setupCommandT
