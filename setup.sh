#!/bin/bash

cd

if ! test -e .ssh/id_rsa ; then
        ssh-keygen
        echo
        echo "Add this deployment key to your repo:"
        echo
        cat .ssh/id_rsa.pub
        echo
        echo "Type ENTER when done: "
        read foo
fi

if ! test -e "$repo" ; then
		sudo yum install git
        git config --global user.name "aws"
        git config --global user.email "aws@$host"
        echo -n "GitHub user name? " ; read user
        echo -n "GitHub repo name? " ; read repo
        git clone "git@github.com:$user/$repo.git"
        cd "$repo"
        source setup.sh
fi

