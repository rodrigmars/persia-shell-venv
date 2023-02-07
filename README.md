# Persia shell-venv

This is repository designed to support shell automation scripts for virtual environments in python.

With this script it is possible to create a small castle to store the python execution packages without external interference.

## Shebang and his behaviors

Before some important points about the types of shebang that should be used in the shell script.

Simple portability to legacy systems:

```shell
#!/bin/sh
```

For extra features

```shell
#!/bin/bash
```

Sets an absolute */usr/bin/bash* path to Bash. Low portability for systems that have other interpreters installed, more security

```shell
#!/usr/bin/bash
```

The *-r* option enables strict shell mode.

```shell
#!/usr/bin/bash -r
```

First it displays the environment variables and then executes the commands with the given interpreter, it offers more portability.

```shell
#!/usr/bin/env bash
```

## How to run it

```bash
chmod +x persia_shell.sh

./persia_shell.sh
```
