#Perl mailer utility

#!/usr/bin/perl

use strict;
  use warnings;
  use Email::Send;
  use Email::Send::Gmail;
  use Email::Simple::Creator;

  my $email = Email::Simple->create(
      header => [
          From    => 'yorko9999@gmail.com',
          To      => 'yorko9999@gmail.com',
          Subject => 'Reporting Problems with the site',
      ],
      body => 'We have an issue with the site. You are experiencing problems either with the server, with apache or with mysql!',
  );

  my $sender = Email::Send->new(
      {   mailer      => 'Gmail',
          mailer_args => [
              username => 'yorko9999@gmail.com',
              password => 'password',
          ]
      }
  );
  eval { $sender->send($email) };
