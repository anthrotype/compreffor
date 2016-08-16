#!/bin/bash

set -e

if [[ "$(uname -s)" == "Darwin" ]]; then
    PYENV_ROOT="$HOME/.pyenv"
    PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

source ~/.venv/bin/activate
tox
