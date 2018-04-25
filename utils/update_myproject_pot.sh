#/bin/bash
### Extract translatable strings of myproject
### and update the file 'myproject.pot'.
###
### Run it on a copy of myproject that is just
### cloned from git, don't run it on an installed
### copy of myproject, otherwise 'potx-cli.php'
### will scan also the other modules that are on
### the directory 'modules/'.

### go to the myproject directory
cd $(dirname $0)
cd ..

### extract translatable strings
utils/potx-cli.php

### concatenate files 'general.pot' and 'installer.pot' into 'myproject.pot'
msgcat --output-file=myproject.pot general.pot installer.pot
rm -f general.pot installer.pot
mv -f myproject.pot l10n/

### merge/update with previous translations
for po_file in $(ls l10n/myproject.*.po)
do
    msgmerge --update --previous $po_file l10n/myproject.pot
done

