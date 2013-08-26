#!/bin/sh

# This has to be run from master
git checkout master

# Update our list of remotes
git fetch
git remote prune origin

# Remove local fully merged branches
git branch --merged master | grep -v 'master$' | xargs git branch -d

# Show remote fully merged branches
echo "The following remote branches are fully merged and will be removed:"
git branch -r --merged master | grep -e '\s*origin' | sed 's/ *origin\///' | grep -v 'master$'

read -p "Continue (y/n)? "
if [ "$REPLY" == "y" ]
then
   # Remove remote fully merged branches
   git branch -r --merged master | grep -e '\s*origin' | sed 's/ *origin\///' \
             | grep -v 'master$' | xargs -I% git push origin :%
   echo "Done!"
fi
