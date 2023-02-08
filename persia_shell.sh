#!/bin/bash

. init.conf

checkProjectExists() {

    if [[ -d $PROJECT_NAME ]]; then
        printf "${RED}Erro:=${YELLOW} Directory $PROJECT_NAME already exists, please check🔴${COLOR_OFF}\n"
        exit 1
    fi

    return 0
}


checkParameters() {

    if [[ -z $PROJECT_NAME ]]; then
        printf "${RED}Erro:=${YELLOW}Please enter a valid project name🔴${COLOR_OFF}\n"
        exit 1
    fi

    if [[ $PROJECT_NAME =~ [^a-zA-Z0-9_-] ]]; then
        printf "${RED}Erro:=${YELLOW}Enter only numbers and letters🔴${COLOR_OFF}\n"
        exit 1
    fi

    return 0
}

createPackages() {

    printf "${GREEN}CREATING THE PACKAGES${RED}...🟡${COLOR_OFF}\n\n"

    mkdir $PROJECT_NAME && cd $PROJECT_NAME

    mkdir $PROJECT_NAME

    mkdir $DIR_TESTS

    printf "${GREEN}generated packages 🟢${COLOR_OFF}\n\n"

    printf "${GREEN}virtualizing and activating environment${RED}...🟡<<${COLOR_OFF}\n\n"

    python -m venv venv-$PROJECT_NAME

    printf "${GREEN}Virtual environment created for venv-$PROJECT_NAME...🟢<<${COLOR_OFF}\n\n"

}

createModules() {

    printf "${YELLOW}creating development modules${COLOR_OFF}\n\n"

    touch $PROJECT_NAME/__init__.py

    touch $PROJECT_NAME/app.py

    printf "${YELLOW}creating test modules${COLOR_OFF}\n\n"

    touch $DIR_TESTS/__init__.py

    touch $DIR_TESTS/test_main.py

}


creatingEnvironment() {

    source venv-$PROJECT_NAME/bin/activate

    printf "PATH:$(which python)\n"

    printf "PYTHON_VERSION:$(python --version)\n\n" 
    
    if [[ $VERBOSE -eq 1 ]]; then comando="pip install -q"; else comando="pip install"; fi
    
    printf "${GREEN}UPDATING PIP TOOL${RED}...<<${COLOR_OFF}\n\n"

    python -m $comando --upgrade pip   
}

configLibs() {
    
    COUNTER=0

    LEN_LIBS_PYTHON=${#LIBS_PYTHON[@]}

    python_library=""

    for item in ${LIBS_PYTHON[@]}
    do
    
        python_library=$item

        $comando $item

        printf "\n${YELLOW}>>...lib $item${COLOR_OFF}\n\n"

        let COUNTER++

        if [[ COUNTER -lt $LEN_LIBS_PYTHON ]]; then
            requirements+=$item"\|"
        else
            requirements+=$item
        fi

        sleep 3
    done

    if [[ $VERBOSE -eq 0 ]]; then 
        
        printf "\n${YELLOW}Collecting data from installed libraries${COLOR_OFF}\n\n"

        for item in $LIBS_PYTHON
        do
            pip show $item
            sleep 3
        done
    fi
}

managePythonLibraries() {

    requirements=""

    printf "\n${yellow}downloading and installing libraries...🟡${color_off}\n\n"

    {
        configLibs
    } || {
        printf "${RED}Erro:=${YELLOW}Failed to install python library $python_library 🔴${COLOR_OFF}\n"
        exit 1
    }

    printf "\n${YELLOW}libraries successfully installed 🟢${COLOR_OFF}\n\n"


    printf "${YELLOW}requirements being generated...🟡${COLOR_OFF}\n\n"

    if [[ ! -n $requirements ]]; then
        printf "${RED}Erro:=${YELLOW}No python libraries to compose application file 🔴${COLOR_OFF}\n"
        exit 1
    fi

    $(pip freeze | grep -i $requirements > requirements.txt)

    printf "${YELLOW}requirements successfully generated 🟢${COLOR_OFF}\n\n"

}

if checkProjectExists; then

    if checkParameters; then

        printf "\n\n\n${GREEN}[¬º-°]¬${RED}.*･｡ﾟ>>...${YELLOW}STARTING ENVIRONMENT VIRTUALIZATION...🟡${GREEN}\n\n\n"

        createPackages

        createModules

        creatingEnvironment

        printf "${YELLOW}Virtual environment created for $PROJECT_NAME 🟢${COLOR_OFF}\n\n"

        printf "${GREEN}ԅ(≖‿≖ԅ)\n\n"

        deactivate

        exit 0
    fi

fi