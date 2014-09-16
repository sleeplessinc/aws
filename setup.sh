#!/bin/bash

echo 
echo "THIS IS GOING TO CLOBBER A LOT OF STUFF!"
echo "Type ^C to cancel"
read foo

rm -f ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
ssh-keygen -f ~/.ssh/id_rsa -P ""

echo
echo "Deployment key:"
echo
cat .ssh/id_rsa.pub
echo
echo -n "Type ENTER when done "
read a

sudo yum -y install git

host=`hostname`
git config --global user.name "server"
git config --global user.email "server@$host.com"

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

