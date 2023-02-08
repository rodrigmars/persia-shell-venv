#!/bin/bash

. init.conf

checkProjectExists() {

    if [[ -d $PROJECT_NAME ]]; then
        printf "${YELLOW} Directory $PROJECT_NAME already exists, please check ${COLOR_OFF}\n"
        exit 1
    fi

    return 0
}


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

createPackages() {

    printf "${GREEN}CREATING THE PACKAGES${RED}...<<${COLOR_OFF}\n\n"

    mkdir $PROJECT_NAME && cd $PROJECT_NAME

    mkdir $PROJECT_NAME

    mkdir $DIR_TESTS

    printf "${GREEN}FORTRESS RAISED${RED}...<<${COLOR_OFF}\n\n"

    printf "${GREEN}VIRTUALIZING STRUCTURE${RED}...<<${COLOR_OFF}\n\n"

    python -m venv venv-$PROJECT_NAME

    printf "${GREEN}ENABLING VIRTUALIZED ENVIRONMENT${RED}...<<${COLOR_OFF}\n\n"

    printf "PROJECT_NAME:venv-$PROJECT_NAME\n"

}

createModules() {

    # printf $sentence

    printf "\n${YELLOW}... libraries successfully installed ...${COLOR_OFF}\n\n"

    printf "\n${YELLOW}･｡･｡ creating development modules${COLOR_OFF}\n\n"

    touch $PROJECT_NAME/__init__.py

    touch $PROJECT_NAME/app.py

    printf "\n${YELLOW}･｡･｡ creating test modules${COLOR_OFF}\n\n"

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

    printf "\n${YELLOW}DOWNLOADING AND INSTALLING LIBRARIES${COLOR_OFF}\n\n"
   
}

configLibs() {
 
    counter=0

    total=${#LIBS_PYTHON[@]}

    for item in ${LIBS_PYTHON[@]}
    do
    
        $comando $item
        
        printf "\n${YELLOW}>>...lib $item${COLOR_OFF}\n\n"

        if [[ counter -lt total-1 ]]; then
            # sentence+=$item"\|"
            sentence+=$item"|"
        else
            sentence+=$item
        fi

        let counter++

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

createRequirements() {

    printf "\n${YELLOW}generate requirements ...${COLOR_OFF}\n\n"

    # $(pip freeze | grep -i $sentence > requirements.txt)
    $(pip freeze | grep -E $sentence > requirements.txt)

    printf "\n${YELLOW}... nothing else to do ...${COLOR_OFF}\n\n"

}

if checkProjectExists; then

    if checkParameters; then

        printf "\n\n\n${GREEN}[¬º-°]¬${RED}.*･｡ﾟ>>...${YELLOW}STARTING ENVIRONMENT VIRTUALIZATION...${GREEN}ԅ(≖‿≖ԅ)\n\n\n"

        createPackages

        createModules

        creatingEnvironment

        configLibs

        createRequirements

        printf "${GREEN}ԅ(≖‿≖ԅ)\n\n\n"

        printf "\n${YELLOW}Virtual environment created for $PROJECT_NAME ${COLOR_OFF}\n\n\n"

        deactivate

        exit 0
    fi

fi