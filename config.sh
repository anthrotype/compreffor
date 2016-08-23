# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    :
}

function run_tests {
    # The function is called from an empty temporary directory.
    # Get absolute path to the pre-compiled wheel
    wheelhouse=$(abspath ../wheelhouse)
    wheel=`ls ${wheelhouse}/compreffor*.whl | head -n 1`

    # select tox environment
    case "${PYTHON_VERSION}" in
        2.7)
           TOXENV=py27
           ;;
        3.4)
           TOXENV=py34
           ;;
        3.5)
           TOXENV=py35
           ;;
    esac

    # Runs tests on installed wheel
    tox --installpkg $wheel -e $TOXENV
}
