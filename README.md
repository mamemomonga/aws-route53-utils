# Route53

AWS Route53をCLIから利用するためのメモ

## AWS コマンドラインインターフェイス
* [AWS コマンドラインインターフェイス](https://aws.amazon.com/jp/cli/)
* [AWS CLI Command Reference route53](http://docs.aws.amazon.com/cli/latest/reference/route53/)

### インストールと設定

	$ pip install awscli
	$ aws configure
	AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
	AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
	Default region name [None]: ap-northeast-1
	Default output format [None]: ENTER

## cli53
* [cli53](https://github.com/barnybug/cli53)
* bind形式でのエクスポート・インポートができたりいろいろできる。
* 設定はawsコマンドの設定(~/.aws/credentials) が使われる

### インストール

	$ brew install cli53
	$ cli53 list

## route53-change-ttl.pl
hosted zone にある A,TXT,CNAME,MX レコードのすべてを指定したTTLに変更するツール

aws, Perl, JSON::XS, IO::All が必要

	./route53-change-ttl.pl [hosted_zone_id] [ttl]
	./route53-change-ttl.pl ABCDEFGHIJKLM1 3600

