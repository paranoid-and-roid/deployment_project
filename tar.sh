#!/bin/bash
cd /tmp
#
SANDBOX=sandbox_$RANDOM
mkdir $SANDBOX
cd $SANDBOX
ERRORCHECK=0
# Make test webpackage
mkdir build

git clone https://github.com/FSlyne/NCIRL.git

cp NCIRL/Apache/www/* build
cp NCIRL/Apache/cgi-bin/* build

chmod a+x build/*

echo " "

if [ -f build/form.html ] 
then
echo form.html is present in the build folder
else
echo form.html is not present
fi
if [ -f build/accept_form.pl ] 
then
echo accept_form.pl is present in the build folder
else
echo accept_form.pl is not present
fi

echo " "

# Make the process directories

mkdir integrate
mkdir test
mkdir deploy
#
# Make webpackage and move webpackage
#
tar -zcvf package_preIntegrate.tgz build
MD5SUM=$(md5sum package_preIntegrate.tgz | cut -f 1 -d' ')
PREVMD5SUM=$(cat /tmp/md5sum)
FILECHANGE=0
if [[ "$MD5SUM" != "$PREVMD5SUM" ]]
then
        FILECHANGE=1
        echo $MD5SUM not equal to $PREVMD5SUM, so we are continuing on to the Integrate phase.
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

# INTEGRATE

mv package_preIntegrate.tgz build
rm -rf build
cd integrate
tar -zxvf package_preIntegrate.tgz

tar -zcvf package_preTest.tgz test
MD5SUM=$(md5sum package_preTest.tgz | cut -f 1 -d' ')
PREVMD5SUM=$(cat /tmp/md5sum)
FILECHANGE=0
if [[ "$MD5SUM" != "$PREVMD5SUM" ]]
then
        FILECHANGE=1
        echo $MD5SUM not equal to $PREVMD5SUM, so we are continuing on to the Testing phase.
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
