#!/bin/bash

cd /tmp
SANDBOX=sandbox_$RANDOM
mkdir $SANDBOX
cd $SANDBOX
# Make the process directories
mkdir build
mkdir integrate
mkdir test
mkdir deploy
#BUILD
cd build
git clone https://github.com/FSlyne/NCIRL.git

tar -czvf pre_integrate.tgz NCIRL
mv pre_integrate.tgz -t /tmp/integrate
rm -rf NCIRL
cd ..
#INTEGRATE

cd integrate

tar -zxvf pre_integrate.tgz
rm pre_integrate.tgz

cd NCIRL
cat<<FINISH | mysql -uroot -ppassword
drop database if exists dbtest;
CREATE DATABASE dbtest;
GRANT ALL PRIVILEGES ON dbtest.* TO dbtestuser@localhost IDENTIFIED BY 'dbpassw$
use dbtest;
drop table if exists custdetails;
create table if not exists custdetails (
name         VARCHAR(30)   NOT NULL DEFAULT '',
address         VARCHAR(30)   NOT NULL DEFAULT ''
);
insert into custdetails (name,address) values ('John Smith','Street Address');
FINISH

cd ..
tar -czvf pre_test.tgz NCIRL
mv pre_test.tgz -t /tmp/$SANDBOX/test
rm -rf NCIRL
cd ..

#TEST

cd test
tar -zxvf pre_test.tgz
rm pre_test.tgz
cd NCIRL
cat<<FINISH | mysql -uroot -ppassword
use dbtest;
select*from custdetails;
FINISH
cd ..
tar -czvf pre_deploy.tgz NCIRL
mv pre_deploy.tgz -t /tmp/$SANDBOX/deploy
rm -rf NCIRL
cd ..
#DEPLOY
cd deploy
tar -zxvf pre_test.tgz
rm pre_test.tgz
cd NCIRL/Apache
sudo cp -R www /var
sudo cp -R cgi-bin /usr/lib
sudo chmod +x /usr/lib/cgi-bin/accept_form.pl

