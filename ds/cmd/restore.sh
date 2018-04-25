cmd_restore_help() {
    cat <<_EOF
    restore <backup-file.tgz>
        Restore application from the given backup file.

_EOF
}

cmd_restore() {
    # get the backup file
    local file=$1
    test -f "$file" || fail "Usage:\n$(cmd_restore_help)"
    [[ $file != ${file%%.tgz} ]] || fail "Usage:\n$(cmd_restore_help)"

    # get the type of backup and
    # call the appropriate restore function
    local type=$(echo $file | cut -d- -f2)
    set -x
    case $type in
        full)
            _make_full_restore $file
            ;;
        data)
            _make_data_restore $file
            ;;
        *)
            _make_app_restore $file
            ;;
    esac
}

_make_app_restore() {
    local file=$1
    local app=$(echo $file | cut -d- -f2)
    local backup=${file%%.tgz}
    backup=$(basename $backup)

    # disable the site for maintenance
    ds exec drush @$app vset maintenance_mode 1

    # extract the backup archive
    tar --extract --gunzip --preserve-permissions --file=$file

    # restore the database
    ds exec drush @$app sql-drop --yes
    ds exec drush @$app sql-query \
       --file=/host/$backup/$app.sql

    # restore application files
    rm -rf var-www/$app
    cp -a $backup/$app var-www/

    # clean up
    rm -rf $backup

    # enable the site
    ds exec drush @$app vset maintenance_mode 0
}

_make_full_restore() {
    local file=$1
    local backup=${file%%.tgz}
    backup=$(basename $backup)

    # disable the site for maintenance
    ds exec drush --yes @local_proj vset maintenance_mode 1

    # extract the backup archive
    tar --extract --gunzip --preserve-permissions --file=$file

    # restore the content of the database
    ds exec drush @proj sql-drop --yes
    ds exec drush @proj sql-query \
       --file=/host/$backup/proj.sql

    # restore application files
    rm -rf var-www/{proj,downloads}
    cp -a $backup/{proj,downloads} var-www/

    # restore proj_dev
    if [[ -f $backup/proj_dev.sql ]]; then
        ds exec drush @proj_dev sql-drop --yes
        ds exec drush @proj_dev sql-query \
           --file=/host/$backup/proj_dev.sql

        rm -rf var-www/proj_dev
        cp -a $backup/proj_dev var-www/
    fi

    # clean up
    rm -rf $backup

    # enable the site
    ds exec drush --yes @local_proj vset maintenance_mode 0
}

_make_data_restore() {
    # disable the site for maintenance
    ds exec drush --yes @local_proj vset maintenance_mode 1

    # extract the backup archive
    tar --extract --gunzip --preserve-permissions --file=$file

    # get the name of the backup dir
    local file=$1
    local backup=${file%%.tgz}
    backup=$(basename $backup)

    # restore the data from the backup dir
    ds inject restore.sh $backup

    # clean up
    rm -rf $backup

    # enable the site
    ds exec drush --yes @local_proj vset maintenance_mode 0
}
