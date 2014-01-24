#!/bin/bash
cd /tmp
#
SANDBOX=sandbox_$RANDOM
mkdir $SANDBOX
cd $SANDBOX
ERRORCHECK=0
# Make test webpackage
mkdir webpackage


git clone https://github.com/FSlyne/NCIRL.git
cd NCIRL


cp NCIRL/Apache/www/form.html webpackage/form.html
# Make the process directories
mkdir build
mkdir integrate
mkdir test
mkdir deploy
#
# Make webpackage and move webpackage
#
tar -zcvf webpackage_preBuild.tgz webpackage
MD5SUM=$(md5sum webpackage_preBuild.tgz | cut -f 1 -d' ')
PREVMD5SUM=$(cat /tmp/md5sum)
FILECHANGE=0
if [[ "$MD5SUM" != "$PREVMD5SUM" ]]
then
        FILECHANGE=1
        echo $MD5SUM not equal to $PREVMD5SUM
else
        FILECHANGE=0
        echo $MD5SUM equal to $PREVMD5SUM
fi
echo $MD5SUM > /tmp/md5sum
if [ $FILECHANGE -eq 0 ]
then
        echo no change in files, doing nothing and exiting
        exit
fi




cd /tmp
rm -rf $SANDBOX
