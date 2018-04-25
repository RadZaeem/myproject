#!/bin/bash -x

source /host/settings.sh

### make sure that we have the right git branch on the make file
makefile="$CODE_DIR/build-myproject.make"
git_branch=$(git -C $CODE_DIR branch | cut -d' ' -f2)
sed -i $makefile \
    -e "/myproject..download..branch/ c projects[myproject][download][branch] = $git_branch"

### retrieve all the projects/modules and build the application directory
rm -rf $DRUPAL_DIR
drush make --prepare-install --force-complete \
           --contrib-destination=profiles/myproject \
           $makefile $DRUPAL_DIR

### Replace the profile myproject with a version
### that is a git clone, so that any updates
### can be retrieved easily (without having to
### reinstall the whole application).
cd $DRUPAL_DIR/profiles/
mv myproject myproject-bak
cp -a $CODE_DIR .
### copy contrib libraries and modules
cp -a myproject-bak/libraries/ myproject/
cp -a myproject-bak/modules/contrib/ myproject/modules/
cp -a myproject-bak/themes/contrib/ myproject/themes/
### cleanup
rm -rf myproject-bak/

### copy the bootstrap library to the custom theme, etc.
cd $DRUPAL_DIR/profiles/myproject/
cp -a libraries/bootstrap themes/contrib/bootstrap/
cp -a libraries/bootstrap themes/myproject/
cp libraries/bootstrap/less/variables.less themes/myproject/less/

### copy the logo file to the drupal dir
ln -s $DRUPAL_DIR/profiles/myproject/myproject.png $DRUPAL_DIR/logo.png

### set propper directory permissions
cd $DRUPAL_DIR
mkdir -p sites/all/translations
chown -R www-data: sites/all/translations
mkdir -p sites/default/files/
chown -R www-data: sites/default/files/
mkdir -p cache/
chown -R www-data: cache/
### create the downloads dir
mkdir -p /var/www/downloads/
chown www-data /var/www/downloads/
