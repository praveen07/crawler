#!/usr/bin/perl -w

use strict;
use Data::Dumper;
use redis;
use Log::Log4perl;

package MyParser;

use Log::Log4perl qw(:easy);
Log::Log4perl->easy_init($DEBUG);

our $web_domain = "http://www.espncricinfo.com/";
our @frontier_url_list = ("http://www.espncricinfo.com/india/content/player/country.html?country=6");

INFO ("Starting Master");
our $redis = MyRedis->new;
$redis->init();
foreach my $url (@frontier_url_list) {
	DEBUG $url;
	$redis->push_url($url);
	}

