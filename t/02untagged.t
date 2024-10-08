#!/usr/bin/perl

use strict;
use warnings;

use FindBin '$Bin';
use Test::More;
use File::Temp 'tempdir';

require_ok("$Bin/../bin/squaretag");

my $dir = tempdir( CLEANUP => 1 );
chdir($dir) or die "Can't chdir to $dir: $!";

is_deeply( find_untagged(()),                               [] );
is_deeply( find_untagged(qw(file01.txt)),                 [qw(file01.txt)] );
is_deeply( find_untagged(qw(file01.txt file02[foo].txt)), [qw(file01.txt)] );
is_deeply( find_untagged(qw(file01.txt file02[foo].txt file03.txt)),
    [qw(file01.txt file03.txt)] );
is_deeply( find_untagged(qw(file02[foo].txt)), [] );

done_testing;
