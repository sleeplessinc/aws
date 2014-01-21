#!/bin/bash

cd

if ! test -e .ssh/id_rsa ; then
        echo -n "GitHub user name? "
        read user
        echo -n "GitHub repo name? "
        read repo
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
	git config --global user.name "aws"
	git config --global user.email "aws@$host"
	git clone "git@github.com:$user/$repo.git"
	cd "$repo"
	source setup.sh
fi

