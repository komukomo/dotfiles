#!/bin/bash
#
# @(#) install.sh  - install dotfiles
#

DOT_DIR="$HOME/.kmkm-dotfiles"

main() {
	echo "run install.sh ..."
	get_repo
	cd ${DOT_DIR}
	config_git
	do_install
}

config_git() {
	git config user.name komukomo
	git config user.email komukomo@users.noreply.github.com
}

get_repo() {
	if [ ! -e ${DOT_DIR} ]; then
		git clone https://github.com/komukomo/dotfiles.git ${DOT_DIR}
	else
		echo "${DOT_DIR} already exists."
	fi
}

do_install() {
	DIRPATH=$(cd `dirname $0`; pwd)
	cd ${DIRPATH}

	TARGETS=$(git ls-files ".*")

	for file in ${TARGETS[@]}
	do
		ln -s ${DIRPATH}/${file} ${HOME}/${file}
		if [ $? -eq 0 ]; then
			echo "success to create sym link: ${file}"
		fi
	done
}

main
