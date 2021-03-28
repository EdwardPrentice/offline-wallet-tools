#!/bin/bash -eu

if [[ $# -eq 0 ]] ; then
    echo "No argument supplied"
    exit 1
fi

gpgconf --reload gpg-agent
gpg --cipher-algo AES256 --symmetric $1
gpgconf --reload gpg-agent
