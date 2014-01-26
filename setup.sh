#!/bin/bash

cd
echo "This is going to do a lot of clobbering."
echo -n "Are you quite sure you want to do this? "
read a
if [ "$a" = "yes" ] ; then


rm -f ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
ssh-keygen -f ~/.ssh/id_rsa


echo
echo "Add deployment key to repo:"
echo
cat .ssh/id_rsa.pub
echo
echo -n "Type ENTER when done "
read a


sudo yum -y install git
host=`hostname`
git config --global user.name "aws"
git config --global user.email "aws@$host"
echo -n "GitHub user name? " ; read user
echo -n "GitHub repo name? " ; read repo

if test -e "$repo" ; then
	rm -rfv "$repo"
fi

git clone "git@github.com:$user/$repo.git"
cd "$repo"
if test -e setup.sh ; then
	source setup.sh
else
	echo "No setup.sh found."
fi

cd

echo "Done."

