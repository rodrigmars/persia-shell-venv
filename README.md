# Persia shell-venv

This is repository designed to support shell automation scripts for virtual environments in python.

With this script it is possible to create a small castle to store the python execution packages without external interference.

## Technical Specifications

For a perfect execution, I chose to use a configuration file [init.conf](https://github.com/rodrigmars/persia-shell-venv/blob/main/init.conf) that loads necessary information and dependencies as follows:

- PROJECT_NAME
  - project name information

- LIBS_PYTHON
  - enter your libraries here

- DIR_TESTS
  - test directory
  
- VERBOSE
  - verbosity in debug output

- REQUIREMENTS_FILE
  - takes requirements file name

## How to run it

```bash
chmod u+x persia_shell.sh

./persia_shell.sh
```
