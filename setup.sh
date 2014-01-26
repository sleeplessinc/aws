#!/bin/bash

cd

if ! test -e .ssh/id_rsa ; then
	rm -f ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
	ssh-keygen
fi

echo
echo "Add this deployment key to your repo:"
echo
cat .ssh/id_rsa.pub
echo
echo "Type ENTER when done: "
read foo

if ! test -e "$repo" ; then
	sudo yum -y install git
	host=`hostname`
	git config --global user.name "aws"
	git config --global user.email "aws@$host"
	echo -n "GitHub user name? " ; read user
	echo -n "GitHub repo name? " ; read repo
	git clone "git@github.com:$user/$repo.git"
	cd "$repo"
	if test -e setup.sh ; then
		source setup.sh
	fi
fi

