#!/bin/bash

set -e

if [[ "$(uname -s)" == 'Darwin' ]]; then
    # on OSX we need pyenv to install python > 2.7
    git clone https://github.com/yyuu/pyenv.git ~/.pyenv
    PYENV_ROOT="$HOME/.pyenv"
    PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    case "${TOXENV}" in
        py27)
            # install pip on the system python
            curl -O https://bootstrap.pypa.io/get-pip.py
            python get-pip.py --user
            ;;
        py34)
            pyenv install 3.4.4
            pyenv global 3.4.4
            ;;
        py35)
            pyenv install 3.5.2
            pyenv global 3.5.2
            ;;
    esac
    pyenv rehash
    python -m pip install --user --upgrade pip virtualenv
else
    # on Linux, we just update pip and virtualenv
    pip install --upgrade pip virtualenv
fi

# activate virtualenv and install test requirements
python -m virtualenv ~/.venv
source ~/.venv/bin/activate
pip install tox
