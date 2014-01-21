#!/bin/bash

cd

if ! test -e .ssh/id_rsax ; then
        echo -n "Repo? "
        read repo
        # ssh-keygen
        echo "Put this in github deployment keys and re-run this script:\n"
        cat .ssh/id_rsa.pub
        echo "\nThen re-run this script."
        exit 0;
fi

