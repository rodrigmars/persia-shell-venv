#!/bin/bash

. init.conf

check_project_exists() {

    MESSAGE_ERROR="Directory $PROJECT_NAME already exists, please check"

    [[ -d $PROJECT_NAME ]] && log_error "$MESSAGE_ERROR" || return 0
}

check_parameters() {

    [[ -z $PROJECT_NAME ]] && log_error "Please enter a valid project name" || 
    [[ $PROJECT_NAME =~ [^a-zA-Z0-9_-] ]] && log_error "Enter only numbers and letters" || 
    return 0
}

creating_packages() {

    log_message "creating the packages$..."

    mkdir $PROJECT_NAME && cd $PROJECT_NAME

    mkdir $PROJECT_NAME

    mkdir $DIR_TESTS

    log_message "generated packages"

    log_message "virtualizing and activating environment..."

    python -m venv venv-$PROJECT_NAME

    log_message "virtual environment created for venv-$PROJECT_NAME..."

}

creating_modules() {

    log_message "creating program and test modules..."

    touch $PROJECT_NAME/__init__.py

    touch $PROJECT_NAME/app.py

    touch $DIR_TESTS/__init__.py

    touch $DIR_TESTS/test_main.py

    log_message "modules created"

}

creating_environment() {

    source venv-$PROJECT_NAME/bin/activate

    log_message "PATH:${YELLOW}$(which python)"

    log_message "PYTHON_VERSION:${YELLOW}$(python --version)" 
}

updating_pip() {

    log_message "updating pip tool..."
    
    [[ $VERBOSE -eq 1 ]] && comando="pip install -q" || comando="pip install"

    python -m $comando --upgrade pip

    log_message "pip updated to version:${YELLOW}\n$(pip --version)"
}

install_libraries() {

    log_message "downloading and installing libraries..."
    
    for item in $LIBS_PYTHON
    do
    
        $comando $item || log_error "Error installing package $item"

        printf "${YELLOW}>>...lib $item\n\n"

        sleep 3
    done

    log_message "libraries successfully installed"

}

creating_requirements() {

    log_message "requirements being generated..."

    requirements=${LIBS_PYTHON// /\\|}

    [[ ! -n $requirements ]] && log_error "No python libraries to compose requirements file"

    $(pip freeze | grep -i $requirements > "$REQUIREMENTS_FILE" || log_error)

    [[ ! -s "$REQUIREMENTS_FILE" ]] && log_error "Error when trying to generate requirements file" || 

    log_message "requirements successfully generated"

}

if check_project_exists; then

    if check_parameters; then

        clear

        printf "\n\n\n${GREEN}=|º|= ${YELLOW}STARTING ENVIRONMENT VIRTUALIZATION ${GREEN}=|º|=${GREEN}\n\n\n"

        creating_packages

        creating_modules

        creating_environment

        updating_pip

        install_libraries

        creating_requirements

        log_message "Virtual environment created for $PROJECT_NAME"

        printf "${RED}ԅ(≖‿≖ԅ)\n\n"

        deactivate

        exit 0
    fi

fi

