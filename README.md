# Route53ツール

* [aws cli](https://aws.amazon.com/jp/cli/)
* [AWS CLI Command Reference route53](http://docs.aws.amazon.com/cli/latest/reference/route53/)

Perl, JSON::XS, IO::All が必要

# route53-change-ttl.pl
hosted zone の A,TXT,CNAME,MX レコードを特定のTTLに変更する

	./route53-change-ttl.pl [hosted_zone_id] [ttl]

	./route53-change-ttl.pl ABCDEFGHIJKLM1 3600

