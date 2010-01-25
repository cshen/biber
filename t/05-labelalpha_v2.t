use strict;
use warnings;
use utf8;
use Storable qw (dclone);
no warnings 'utf8';

use Test::More tests => 64;

use Biber;
use Log::Log4perl qw(:easy);
Log::Log4perl->easy_init($ERROR);

chdir("t/tdata");

my $bibfile;
my $biber = Biber->new;
Biber::Config->setoption('fastsort', 1);
Biber::Config->setoption('locale', 'C');
$biber->parse_auxfile_v2('60-labelalpha_v2.aux');
$bibfile = Biber::Config->getoption('bibdata')->[0] . '.bib';
$biber->parse_bibtex($bibfile);

Biber::Config->setblxoption('labelalpha', 1);
Biber::Config->setblxoption('labelyear', undef);
Biber::Config->setblxoption('maxnames', 1);
Biber::Config->setblxoption('minnames', 1);
$biber->prepare;

is($biber->{bib}{l1}{sortlabelalpha}, 'Doe95', 'maxnames=1 minnames=1 entry L1 labelalpha');
ok(! defined($biber->{bib}{l1}{extraalpha}), 'maxnames=1 minnames=1 entry L1 extraalpha');
is($biber->{bib}{l2}{sortlabelalpha}, 'Doe+95', 'maxnames=1 minnames=1 entry L2 labelalpha');
is($biber->{bib}{l2}{extraalpha}, '1', 'maxnames=1 minnames=1 entry L2 extraalpha');
is($biber->{bib}{l3}{sortlabelalpha}, 'Doe+95', 'maxnames=1 minnames=1 entry L3 labelalpha');
is($biber->{bib}{l3}{extraalpha}, '2', 'maxnames=1 minnames=1 entry L3 extraalpha');
is($biber->{bib}{l4}{sortlabelalpha}, 'Doe+95', 'maxnames=1 minnames=1 entry L4 labelalpha');
is($biber->{bib}{l4}{extraalpha}, '3', 'maxnames=1 minnames=1 entry L4 extraalpha');
is($biber->{bib}{l5}{sortlabelalpha}, 'Doe+95', 'maxnames=1 minnames=1 entry L5 labelalpha');
is($biber->{bib}{l5}{extraalpha}, '4', 'maxnames=1 minnames=1 entry L5 extraalpha');
is($biber->{bib}{l6}{sortlabelalpha}, 'Doe+95', 'maxnames=1 minnames=1 entry L6 labelalpha');
is($biber->{bib}{l6}{extraalpha}, '5', 'maxnames=1 minnames=1 entry L6 extraalpha');
is($biber->{bib}{l7}{sortlabelalpha}, 'Doe+95', 'maxnames=1 minnames=1 entry L7 labelalpha');
is($biber->{bib}{l7}{extraalpha}, '6', 'maxnames=1 minnames=1 entry L7 extraalpha');
is($biber->{bib}{l8}{sortlabelalpha}, 'Sha85', 'maxnames=1 minnames=1 entry L8 labelalpha');
ok(! defined($biber->{bib}{l8}{extraalpha}), 'maxnames=1 minnames=1 entry L8 extraalpha');

Biber::Config->setblxoption('maxnames', 2);
Biber::Config->setblxoption('minnames', 1);

for (my $i=1; $i<9; $i++) {
  delete $biber->{bib}{"l$i"}{sortlabelalpha};
  delete $biber->{bib}{"l$i"}{labelalpha};
  delete $biber->{bib}{"l$i"}{extraalpha};
}
$biber->prepare;

is($biber->{bib}{l1}{sortlabelalpha}, 'Doe95', 'maxnames=2 minnames=1 entry L1 labelalpha');
ok(! defined($biber->{bib}{l1}{extraalpha}), 'maxnames=2 minnames=1 entry L1 extraalpha');
is($biber->{bib}{l2}{sortlabelalpha}, 'DA95', 'maxnames=2 minnames=1 entry L2 labelalpha');
is($biber->{bib}{l2}{extraalpha}, '1', 'maxnames=2 minnames=1 entry L2 extraalpha');
is($biber->{bib}{l3}{sortlabelalpha}, 'DA95', 'maxnames=2 minnames=1 entry L3 labelalpha');
is($biber->{bib}{l3}{extraalpha}, '2', 'maxnames=2 minnames=1 entry L3 extraalpha');
is($biber->{bib}{l4}{sortlabelalpha}, 'Doe+95', 'maxnames=2 minnames=1 entry L4 labelalpha');
is($biber->{bib}{l4}{extraalpha}, '1', 'maxnames=2 minnames=1 entry L4 extraalpha');
is($biber->{bib}{l5}{sortlabelalpha}, 'Doe+95', 'maxnames=2 minnames=1 entry L5 labelalpha');
is($biber->{bib}{l5}{extraalpha}, '2', 'maxnames=2 minnames=1 entry L5 extraalpha');
is($biber->{bib}{l6}{sortlabelalpha}, 'Doe+95', 'maxnames=2 minnames=1 entry L6 labelalpha');
is($biber->{bib}{l6}{extraalpha}, '3', 'maxnames=2 minnames=1 entry L6 extraalpha');
is($biber->{bib}{l7}{sortlabelalpha}, 'Doe+95', 'maxnames=2 minnames=1 entry L7 labelalpha');
is($biber->{bib}{l7}{extraalpha}, '4', 'maxnames=2 minnames=1 entry L7 extraalpha');
is($biber->{bib}{l8}{sortlabelalpha}, 'Sha85', 'maxnames=2 minnames=1 entry L8 labelalpha');
ok(! defined($biber->{bib}{l8}{extraalpha}), 'maxnames=2 minnames=1 entry L8 extraalpha');


Biber::Config->setblxoption('maxnames', 2);
Biber::Config->setblxoption('minnames', 2);

for (my $i=1; $i<9; $i++) {
  delete $biber->{bib}{"l$i"}{sortlabelalpha};
  delete $biber->{bib}{"l$i"}{labelalpha};
  delete $biber->{bib}{"l$i"}{extraalpha};
}
$biber->prepare;

is($biber->{bib}{l1}{sortlabelalpha}, 'Doe95', 'maxnames=2 minnames=2 entry L1 labelalpha');
ok(! defined($biber->{bib}{l1}{extraalpha}), 'maxnames=2 minnames=2 entry L1 extraalpha');
is($biber->{bib}{l2}{sortlabelalpha}, 'DA95', 'maxnames=2 minnames=2 entry L2 labelalpha');
is($biber->{bib}{l2}{extraalpha}, '1', 'maxnames=2 minnames=2 entry L2 extraalpha');
is($biber->{bib}{l3}{sortlabelalpha}, 'DA95', 'maxnames=2 minnames=2 entry L3 labelalpha');
is($biber->{bib}{l3}{extraalpha}, '2', 'maxnames=2 minnames=2 entry L3 extraalpha');
is($biber->{bib}{l4}{sortlabelalpha}, 'DA+95', 'maxnames=2 minnames=2 entry L4 labelalpha');
is($biber->{bib}{l4}{extraalpha}, '1', 'maxnames=2 minnames=2 entry L4 extraalpha');
is($biber->{bib}{l5}{sortlabelalpha}, 'DA+95', 'maxnames=2 minnames=2 entry L5 labelalpha');
is($biber->{bib}{l5}{extraalpha}, '2', 'maxnames=2 minnames=2 entry L5 extraalpha');
is($biber->{bib}{l6}{sortlabelalpha}, 'DS+95', 'maxnames=2 minnames=2 entry L6 labelalpha');
is($biber->{bib}{l6}{extraalpha}, '1', 'maxnames=2 minnames=2 entry L6 extraalpha');
is($biber->{bib}{l7}{sortlabelalpha}, 'DS+95', 'maxnames=2 minnames=2 entry L7 labelalpha');
is($biber->{bib}{l7}{extraalpha}, '2', 'maxnames=2 minnames=2 entry L7 extraalpha');
is($biber->{bib}{l8}{sortlabelalpha}, 'Sha85', 'maxnames=2 minnames=2 entry L8 labelalpha');
ok(! defined($biber->{bib}{l8}{extraalpha}), 'maxnames=2 minnames=2 entry L8 extraalpha');

Biber::Config->setblxoption('maxnames', 3);
Biber::Config->setblxoption('minnames', 1);

for (my $i=1; $i<9; $i++) {
  delete $biber->{bib}{"l$i"}{sortlabelalpha};
  delete $biber->{bib}{"l$i"}{labelalpha};
  delete $biber->{bib}{"l$i"}{extraalpha};
}
$biber->prepare;

is($biber->{bib}{l1}{sortlabelalpha}, 'Doe95', 'maxnames=3 minnames=1 entry L1 labelalpha');
ok(! defined($biber->{bib}{l1}{extraalpha}), 'maxnames=3 minnames=1 entry L1 extraalpha');
is($biber->{bib}{l2}{sortlabelalpha}, 'DA95', 'maxnames=3 minnames=1 entry L2 labelalpha');
is($biber->{bib}{l2}{extraalpha}, '1', 'maxnames=3 minnames=1 entry L2 extraalpha');
is($biber->{bib}{l3}{sortlabelalpha}, 'DA95', 'maxnames=3 minnames=1 entry L3 labelalpha');
is($biber->{bib}{l3}{extraalpha}, '2', 'maxnames=3 minnames=1 entry L3 extraalpha');
is($biber->{bib}{l4}{sortlabelalpha}, 'DAE95', 'maxnames=3 minnames=1 entry L4 labelalpha');
is($biber->{bib}{l4}{extraalpha}, '1', 'maxnames=3 minnames=1 entry L4 extraalpha');
is($biber->{bib}{l5}{sortlabelalpha}, 'DAE95', 'maxnames=3 minnames=1 entry L5 labelalpha');
is($biber->{bib}{l5}{extraalpha}, '2', 'maxnames=3 minnames=1 entry L5 extraalpha');
is($biber->{bib}{l6}{sortlabelalpha}, 'DSE95', 'maxnames=3 minnames=1 entry L6 labelalpha');
ok(! defined($biber->{bib}{l6}{extraalpha}), 'maxnames=3 minnames=1 entry L6 extraalpha');
is($biber->{bib}{l7}{sortlabelalpha}, 'DSJ95', 'maxnames=3 minnames=1 entry L7 labelalpha');
ok(! defined($biber->{bib}{l7}{extraalpha}), 'maxnames=3 minnames=1 entry L7 extraalpha');
is($biber->{bib}{l8}{sortlabelalpha}, 'Sha85', 'maxnames=3 minnames=1 entry L8 labelalpha');
ok(! defined($biber->{bib}{l8}{extraalpha}), 'maxnames=3 minnames=1 entry L8 extraalpha');

unlink "$bibfile.utf8";
