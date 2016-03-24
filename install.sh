#!/bin/bash

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
