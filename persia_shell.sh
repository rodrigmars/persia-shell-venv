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

    mkdir $PROJECT_NAME

    mkdir $DIR_TESTS

    $(python -m venv venv-$PROJECT_NAME)

    printf "PROJECT_NAME:venv-$PROJECT_NAME\n"

    source venv-$PROJECT_NAME/bin/activate

    printf "PATH:$(which python)\n"

    printf "PYTHON_VERSION:$(python --version)\n" 
    
    python -m pip install --upgrade pip

    if $VERBOSE; then

        printf "\n${YELLOW}Starting the installation of libraries${COLOR_OFF}\n"

        for item in $LIBS_PYTHON
        do
            pip install $item
        done

        printf "\n${YELLOW}Collecting data from installed libraries${COLOR_OFF}\n"

        for item in $LIBS_PYTHON
        do
            lib=$(pip show $item)

            printf "\n$lib\n"

        done
     fi

    deactivate

    touch $PROJECT_NAME/__init__.py

    touch $PROJECT_NAME/app.py

    touch $DIR_TESTS/__init__.py

    touch $DIR_TESTS/test_main.py

}

if checkParameters; then

    creatingEnvironment

    printf "${GREEN}Virtual environment created for $PROJECT_NAME${COLOR_OFF}\n"

    # tree

    exit 0

fi