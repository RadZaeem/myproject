#!/bin/bash -x

source /host/settings.sh

### settings for the database and the drupal site
site_name="Myproject"
site_mail="$GMAIL_ADDRESS"
account_name=admin
account_pass="$ADMIN_PASS"
account_mail="$GMAIL_ADDRESS"

### start site installation
#sed -e '/memory_limit/ c memory_limit = -1' -i /etc/php/7.1/cli/php.ini
cd $DRUPAL_DIR
drush site-install --verbose --yes myproject \
      --db-url="mysql://$DBUSER:$DBPASS@$DBHOST:$DBPORT/$DBNAME" \
      --site-name="$site_name" --site-mail="$site_mail" \
      --account-name="$account_name" --account-pass="$account_pass" --account-mail="$account_mail"

### install additional features
drush="drush --root=$DRUPAL_DIR --yes"
$drush pm-enable proj_layout
$drush features-revert proj_layout

$drush pm-enable bootstrap
$drush pm-enable myproject

$drush pm-enable proj_content

$drush pm-enable proj_captcha
$drush features-revert proj_captcha


#$drush pm-enable proj_invite
#$drush pm-enable proj_simplenews
#$drush pm-enable proj_mass_contact
#$drush pm-enable proj_googleanalytics

### update to the latest version of core and modules
#$drush pm-refresh
#$drush pm-update

### refresh and update translations
if [[ -z $DEV ]]; then
    $drush l10n-update-refresh
    $drush l10n-update
fi
