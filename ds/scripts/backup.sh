#!/bin/bash -x

# go to the backup dir
backup=$1
cd /host/$backup

# backup proj users
mysqldump=$(drush @proj sql-connect | sed -e 's/^mysql/mysqldump/' -e 's/--database=/--databases /')
table_list="users users_roles"
$mysqldump --tables $table_list > $(pwd)/proj_users.sql

# backup enabled features
drush @proj features-list --pipe --status=enabled \
      > $(pwd)/proj_features.txt

# backup drupal variables
dir=/var/www/proj/profiles/btr_client/modules/features
$dir/save-private-vars.sh @proj
mv restore-private-vars.php restore-private-vars-proj.php

# backup twitter configuration
[[ -f /home/twitter/.trc ]] && cp /home/twitter/.trc trc

# custom backup script
[[ -f /host/backup.sh ]] && source /host/backup.sh
