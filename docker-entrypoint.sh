#!/bin/bash
set -e

if [[ "$1" == 'build-tmate' ]]
then
    echo 'INFO: Building tmate'
    cd /tmate
    make -f Makefile.static-build all

    if mountpoint -q /target
    then
        echo "INFO: Installing tmate to /target"
        cp /tmate/tmate /target
    else
        echo "/target is not a mountpoint."
        echo "You can either:"
        echo "- re-run this container with -v /opt/tmate-static/target:/target"
        echo "- extract the tmux binary (located at /tmate)"
    fi
else
    exec "$@"
fi
