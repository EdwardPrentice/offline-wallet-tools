#!/bin/bash -eu

if [[ $# -eq 0 ]] ; then
    echo "No argument supplied"
    exit 1
fi

gpgconf --reload gpg-agent # cleans out any failed attempts
gpg --decrypt $1
gpgconf --reload gpg-agent # forget the password immediately
