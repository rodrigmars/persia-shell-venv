#!/bin/bash

. init.conf

checkProjectExists() {
    
    MESSAGE_ERROR="Directory $PROJECT_NAME already exists, please check"

    [[ -d $PROJECT_NAME ]] && logExitError "$MESSAGE_ERROR" || return 0
}

checkParameters() {

    [[ -z $PROJECT_NAME ]] && logExitError "Please enter a valid project name" || 
    [[ $PROJECT_NAME =~ [^a-zA-Z0-9_-] ]] && logExitError "Enter only numbers and letters" || 
    return 0
}

createPackages() {

    logMessage "creating the packages$..."

    mkdir $PROJECT_NAME && cd $PROJECT_NAME

    mkdir $PROJECT_NAME

    mkdir $DIR_TESTS

    logMessage "generated packages"

    logMessage "virtualizing and activating environment..."

    python -m venv venv-$PROJECT_NAME

    logMessage "virtual environment created for venv-$PROJECT_NAME..."

}

createModules() {

    logMessage "creating program and test modules..."

    touch $PROJECT_NAME/__init__.py

    touch $PROJECT_NAME/app.py

    touch $DIR_TESTS/__init__.py

    touch $DIR_TESTS/test_main.py

    logMessage "modules created"

}

creatingEnvironment() {

    source venv-$PROJECT_NAME/bin/activate

    logMessage "PATH:${YELLOW}$(which python)"

    logMessage "PYTHON_VERSION:${YELLOW}$(python --version)" 
}

updatingPIP() {

    logMessage "updating pip tool..."
    
    [[ $VERBOSE -eq 1 ]] && comando="pip install -q" || comando="pip install"

    python -m $comando --upgrade pip

    logMessage "pip updated to version:${YELLOW}\n$(pip --version)"
}

configLibs() {

    logMessage "downloading and installing libraries..."
    
    COUNTER=0

    LEN_LIBS_PYTHON=${#LIBS_PYTHON[@]}

    for item in ${LIBS_PYTHON[@]}
    do
    
        $comando $item || logExitError "Error installing package $item"

        printf "${YELLOW}>>...lib $item\n\n"

        let COUNTER++

        if [[ COUNTER -lt $LEN_LIBS_PYTHON ]]; then
            requirements+=$item"\|"
        else
            requirements+=$item
        fi

        sleep 3
    done
    
    logMessage "libraries successfully installed"

}

managePythonLibraries() {

    requirements=""

    configLibs

    logMessage "requirements being generated..."

    [[ ! -n $requirements ]] && logExitError "No python libraries to compose requirements file"

    $(pip freeze | grep -i $requirements > requirements.txt) || logExitError
    
    # "Error when trying to generate requirements file"

    logMessage "requirements successfully generated"

}

if checkProjectExists; then

    if checkParameters; then

        clear

        printf "\n\n\n${GREEN}=|º|= ${YELLOW}STARTING ENVIRONMENT VIRTUALIZATION {GREEN}=|º|=${GREEN}\n\n\n"

        createPackages

        createModules

        creatingEnvironment

        updatingPIP

        managePythonLibraries

        logMessage "Virtual environment created for $PROJECT_NAME"

        printf "${RED}ԅ(≖‿≖ԅ)\n\n"

        deactivate

        exit 0
    fi

fi