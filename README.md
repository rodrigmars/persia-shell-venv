# Persia shell-venv

This is repository designed to support shell automation scripts for virtual environments in python.

With this script it is possible to create a small castle to store the python execution packages without external interference.

## Technical Specifications

For a perfect execution, I chose to use a configuration file [init.conf](https://github.com/rodrigmars/persia-shell-venv/blob/main/init.conf) that loads necessary information and dependencies as follows:

- project_name
  - project name information
  
- DIR_TESTS
  - test directory
  
- VERBOSE
  - verbosity in debug output

- LIBS_PYTHON
  - python library list
  
## How to run it

```bash
chmod +x persia_shell.sh

./persia_shell.sh
```
