#!/bin/bash -x

# go to the backup directory
backup=$1
cd /host/$backup

# restore proj users
drush @proj sql-query --file=$(pwd)/proj_users.sql

# enable features
while read feature; do
    drush --yes @proj pm-enable $feature
    drush --yes @proj features-revert $feature
done < proj_features.txt

# restore private variables
drush @proj php-script $(pwd)/restore-private-vars-proj.php

# restore twitter configuration
[[ -f trc ]] && cp trc /home/twitter/.trc

# custom restore script
[[ -f /host/restore.sh ]] && source /host/restore.sh
