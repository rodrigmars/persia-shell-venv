#!/bin/bash

. init.conf
stty -echo

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

    printf "${GREEN}CREATING THE PACKAGES${RED}...<<${COLOR_OFF}\n\n"

    mkdir $PROJECT_NAME && cd $PROJECT_NAME

    mkdir $PROJECT_NAME

    mkdir $DIR_TESTS

    printf "${GREEN}FORTRESS RAISED${RED}...<<${COLOR_OFF}\n\n"

    printf "${GREEN}VIRTUALIZING STRUCTURE${RED}...<<${COLOR_OFF}\n\n"

    python -m venv venv-$PROJECT_NAME

    printf "${GREEN}ENABLING VIRTUALIZED ENVIRONMENT${RED}...<<${COLOR_OFF}\n\n"

    printf "PROJECT_NAME:venv-$PROJECT_NAME\n"

    source venv-$PROJECT_NAME/bin/activate

    printf "PATH:$(which python)\n"

    printf "PYTHON_VERSION:$(python --version)\n\n" 
    
    if [[ $VERBOSE -eq 1 ]]; then comando="pip install -q"; else comando="pip install"; fi
    
    printf "${GREEN}UPDATING PIP TOOL${RED}...<<${COLOR_OFF}\n\n"

    python -m $comando --upgrade pip

    printf "\n${YELLOW}DOWNLOADING AND INSTALLING LIBRARIES${COLOR_OFF}\n\n"

    for item in $LIBS_PYTHON
    do
        $comando $item
        printf "\n${YELLOW}>>...lib $item${COLOR_OFF}\n\n"
    done
    
    if [[ $VERBOSE -eq 0 ]]; then 
        
        printf "\n${YELLOW}Collecting data from installed libraries${COLOR_OFF}\n\n"

        for item in $LIBS_PYTHON
        do
            pip show $item
        done
    fi

    printf "\n${YELLOW}... libraries successfully installed ...${COLOR_OFF}\n\n"

    # stty echo

    printf "\n${YELLOW}･｡･｡ creating development modules${COLOR_OFF}\n\n"

    deactivate

    touch $PROJECT_NAME/__init__.py

    touch $PROJECT_NAME/app.py

    printf "\n${YELLOW}･｡･｡ creating test modules${COLOR_OFF}\n\n"

    touch $DIR_TESTS/__init__.py

    touch $DIR_TESTS/test_main.py

    printf "\n${YELLOW}... nothing else to do ...${COLOR_OFF}\n\n"

}

if checkParameters; then
    
    printf "\n\n\n${GREEN}[¬º-°]¬${RED}.*･｡ﾟ>>...${YELLOW}STARTING ENVIRONMENT VIRTUALIZATION...${GREEN}ԅ(≖‿≖ԅ)\n\n\n"

    creatingEnvironment
  
    printf "\n${YELLOW}Virtual environment created for $PROJECT_NAME ${COLOR_OFF}\n\n\n"

    exit 0

fi