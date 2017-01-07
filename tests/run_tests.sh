#!/bin/bash -e

cd $(dirname $0)

export PYTHONPATH=".."

if [ "$RUNCOVERAGE" == "1" ]; then
    python3 -m coverage run --source robotpy_ext,magicbot -m pytest "$@"
    python3 -m coverage report -m
else
    python3 -m pytest "$@"
fi

# Run tests on examples repository
if [ "$CONTINUOUS_INTEGRATION" == "true" ]; then
    curl https://raw.githubusercontent.com/robotpy/examples/master/_remote_tests.sh | bash -s ext
fi
