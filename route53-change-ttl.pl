#!/usr/bin/env perl
use utf8;
use feature 'say';
use strict;
use warnings;
use JSON::XS;
use IO::All;
use Cwd;

binmode(STDOUT,":utf8");

my $hosted_zone_id=$ARGV[0] || '';
my $ttl=$ARGV[1] || '';

if($ttl eq '') {
	say "change route53 records TTL (A,TXT,CNAME,MX)";
	say "USAGE: $0 [hosted_zone_id] [ttl]";
	exit 1;
}

say "hosted_zone_id: $hosted_zone_id";
say "ttl: $ttl";

my $aws='aws';

my $data;
{
	open(my $pipe,"$aws route53 list-resource-record-sets --hosted-zone-id $hosted_zone_id |") || die $!;
	local $/; $data=decode_json(<$pipe>);
}

my @changes=();
foreach my $rrs(@{$data->{ResourceRecordSets}}) {
	next unless ($rrs->{Type} =~/^(?:A)|(?:TXT)|(?:CNAME)|(?:MX)$/);
	$rrs->{TTL}=$ttl+0;
	push @changes,{
		'Action' => 'UPSERT',
		'ResourceRecordSet' => $rrs
	};
}

my $json=JSON::XS->new()->allow_nonref;
my $upsert=$json->pretty->encode({
	Changes => \@changes
});

io("changes.json")->print($upsert);
system($aws,'route53','change-resource-record-sets','--hosted-zone-id',$hosted_zone_id,'--change-batch','file://'.getcwd().'/changes.json');

