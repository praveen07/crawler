#!/usr/bin/perl -w

use strict;
use Data::Dumper;
use redis;

package MyParser;
use base qw(HTML::Parser);
use LWP::Simple ();

our $web_domain = "http://www.espncricinfo.com/";
our $frontier_url = "http://www.espncricinfo.com/india/content/player/country.html?country=6";
our $playerURL_pattern = "player/[0-9]+.html\$";
our $url_pattern = ".html";
our %already_parsed;

sub start {
	my ($self, $tagname, $attr, $attrseq, $origtext) = @_;
	if ($tagname eq 'a') {
		my $url = $attr->{ href };
		if ( defined($url) && $url =~ /$MyParser::playerURL_pattern/) {
			print "URL found: ", $web_domain . $url, "\n";
			$MyParser::redis->push_url($web_domain . $url);
			#return if $MyParser::already_parsed{ $url };

			# not yet parsed
			#$already_parsed{ $url }++;
			#sleep(1);
			#print "Parsing: ", $url;
			#MyParser->new->parse (LWP::Simple::get($web_domain . $url));
		}
	}
}

our $redis = MyRedis->new;
my $parser = MyParser->new;
my $url = '123';

print "Counting elements \n";

while(1) {
	print "Count is " , $redis->get_count(),"/n";
}
