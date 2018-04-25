#!/bin/bash
### Useful for updating or checking the status of all git repositories.
### For example:
###    git.sh status --short
###    git.sh pull

options=${@:-status --short}
gitrepos="
    /var/www/proj*/profiles/myproject
    /usr/local/src/myproject
"
for repo in $gitrepos
do
    echo
    echo "===> $repo"
    cd $repo
    git $options
done
