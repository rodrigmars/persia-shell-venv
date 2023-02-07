#!/bin/bash

. init.conf

checkParameters() {

    if [[ -z $PROJECT_NAME ]]; then
        printf "${YELLOW}Please enter a valid project name\n${COLOR_OFF}"
        exit 1
    fi

    if [[ $PROJECT_NAME =~ [^a-zA-Z0-9_-] ]]; then
        printf "${YELLOW}Enter only numbers and letters\n${COLOR_OFF}"
        exit 1
    fi

    return 0
}

creatingEnvironment() {

    if [[ -d $PROJECT_NAME ]]; then
        printf "${YELLOW} Directory $PROJECT_NAME already exists, please check ${COLOR_OFF}\n"
        exit 1
    fi

    mkdir $PROJECT_NAME && cd $PROJECT_NAME

    exec pwd

    for item in $LIBS_PYTHON[@]
    do
        echo $item
    done

    # printf "Full path to " && exec pwd

    # mkdir $PROJECT_NAME

    # mkdir DIR_TESTS

    # touch $DIR_PROJECT/__init__.py

    # touch $DIR_PROJECT/app.py

    # touch $DIR_TESTS/__init__.py

    # touch $DIR_TESTS/test_main.py

    # python -m venv $VENV_FOLDER

    # source $VENV_FOLDER/bin/activate

    # code $PROJECT_NAME

}

if checkParameters; then

    creatingEnvironment

    printf "${GREEN}Virtual environment created for $PROJECT_NAME${COLOR_OFF}\n"

    # tree

    exit 0

fi