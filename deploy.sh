#!/bin/bash
SANDBOX=sandbox_$RANDOM
echo Using sandbox $SANDBOX

mkdir $SANDBOX
cd $SANDBOX/
git clone https://github.com/FSlyne/NCIRL.git
cd NCIRL/
#
cp Apache/www/* /var/www/
cp Apache/cgi-bin/* /usr/lib/cgi-bin/
chmod a+x /usr/lib/cgi-bin/*
#

cat <<FINISH | mysql -uroot -password
drop database if exists dbtest;
CREATE DATABASE dbtest;
GRANT ALL PRIVILEGES ON dbtest.* TO dbtestuser@localhost IDENTIFIED BY 'dbpassword';
use dbtest;
drop table if exists custdetails;
create table if not exists custdetails (
name         VARCHAR(30)   NOT NULL DEFAULT '',
address         VARCHAR(30)   NOT NULL DEFAULT ''
);
insert into custdetails (name,address) values ('John Smith','Street Address'); select * from custdetails;
FINISH
#
cd /tmp
rm -rf $SANDBOX

