#!/usr/bin/env bash

dir_root=$1

COLOR_OFF='\033[0m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'

DIR_TESTS=tests
VENV_FOLDER=$dir_root/venv-$dir_root


checkParameters() {

    if [[ -z $dir_root ]]; then
        printf "${YELLOW}Please enter a valid project name\n${COLOR_OFF}"
        exit 1
    fi

    if [[ $dir_root =~ [^a-zA-Z0-9_] ]]; then
        printf "${YELLOW}Enter only numbers and letters\n${COLOR_OFF}"
        exit 1
    fi

    return 0
}

creatingEnvironment() {

    if [[ -d $dir_root ]]; then
        printf "${YELLOW} Directory $dir_root already exists, please check ${COLOR_OFF}\n"
        exit 1
    fi

    mkdir $dir_root

    # cd pastabomba/

    # printf "Full path to " && exec pwd

    # mkdir $dir_root

    # mkdir DIR_TESTS

    # touch $DIR_PROJECT/__init__.py

    # touch $DIR_PROJECT/app.py

    # touch $DIR_TESTS/__init__.py

    # touch $DIR_TESTS/test_main.py

    # python -m venv $VENV_FOLDER

    # source $VENV_FOLDER/bin/activate

    # code $dir_root

}

if checkParameters; then

    creatingEnvironment

    printf "${GREEN}Virtual environment created for $dir_root${COLOR_OFF}\n"

    # tree

    exit 0

fi