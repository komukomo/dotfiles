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
	git config core.ignorecase false
}

get_repo() {
	if [ ! -e ${DOT_DIR} ]; then
		git clone https://github.com/komukomo/dotfiles.git ${DOT_DIR}
	else
		echo "${DOT_DIR} already exists."
	fi
}

do_install() {
	cd ${DOT_DIR}

	TARGETS=$(git ls-files ".*" | awk -F'/' '{print $1}' | uniq)

	for file in ${TARGETS[@]}
	do
		ln -s ${DOT_DIR}/${file} ${HOME}/${file}
		if [ $? -eq 0 ]; then
			echo "symlink craeted: ${file}"
		fi
	done
}

main
