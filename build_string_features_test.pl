#!/usr/bin/perl

use Data::Dumper;
use List::MoreUtils qw/ uniq /;

my $file1 = "/Users/kcb27/Desktop/Git_Workshop/Data/string_human_ppi_test.txt";

my $slink;

my(@all_unps, $slink_new); 

open(FILE, $file1);
while (my $line = <FILE>) {
	chomp($line);

	$line = uc($line);
	next if ($line =~ m/^SOURCE_NAME/);
	
	$line =~s///g;
	my @ele = split(/\t/, $line);
	push(@{$slink->{$ele[0]}},$ele[1]);
	push(@all_unps, ($ele[0], $ele[1]));
	@all_unps = uniq @all_unps;
}
close(FILE);

print Dumper($slink->{'P84085'});
exit;

@all_unps = sort @all_unps;
my ($fp, $test);

foreach my $row_unp(sort keys %$slink) {
	my @targets = @{$slink->{$row_unp}};
	foreach my $col_unp(@all_unps) {
		if (grep {$_ eq $col_unp} @targets) {
			push(@{$fp->{$row_unp}}, 1);
			print "$row_unp\t$col_unp\t1\n";
		}
		else {
			push(@{$fp->{$row_unp}}, 0);
			print "$row_unp\t$col_unp\t0\n";
		}
	}
}
