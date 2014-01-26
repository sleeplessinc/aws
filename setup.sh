#!/bin/bash

cd

if test -e ~/.ssh/id_rsa ; then
	echo -n "Clobber existing ssh key? "
	read a
	if [ "$a" = "yes" ] ; then
		rm -f ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
		ssh-keygen -f ~/.ssh/id_rsa
	fi
fi


echo
echo -n "Need the deployment key for repo? "
read a
if [ "$a" = "yes" ] ; then
	cat .ssh/id_rsa.pub
	echo
	echo "Type ENTER when done: "
	read a
fi


sudo yum -y install git
host=`hostname`
git config --global user.name "aws"
git config --global user.email "aws@$host"
echo -n "GitHub user name? " ; read user
echo -n "GitHub repo name? " ; read repo
if test -e "$repo" ; then
	echo -n "Clobber existing repo clone? "
	read a
	if [ "$a" = "yes" ] ; then
		git clone "git@github.com:$user/$repo.git"
		echo -n "Re-run setup.sh? "
		read a
		if [ "$a" = "yes" ] ; then
			cd "$repo"
			if test -e setup.sh ; then
				source setup.sh
			else
				echo "There is no setup.sh for this repo.  Sorry.";
			fi
			cd
		fi
	fi
fi

