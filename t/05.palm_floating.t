use strict;


use Test::More tests => 13;


use Data::ICal::DateTime;
use Data::ICal::Entry::Event;
use DateTime;
use DateTime::Set;
use DateTime::TimeZone;

my $cal;
ok($cal = Data::ICal->new( filename => 't/ics/palm.ics'), "parse palm ics");

my $date1 = DateTime->new( year => 2005, month => 10, day => 3 );
my $date2 = $date1->clone->add( days => 1 )->subtract( nanoseconds => 1 );

my @events = $cal->events;
use Data::Dumper;
is(scalar(@events),1,"1 event");

my $ev = shift @events;
my $s  = $ev->start;
my $e  = $ev->end;

is("$s", "$date1", "Start is the same as date1");
is ($e, undef, "End if undef");
is($ev->floating, 1, "Event is floating");

is($ev->floating(0), 0, "Set floating to 0");

$s  = $ev->start;
$e  = $ev->end;

is("$s", "$date1", "Start is still the same as date1");
is("$e", "$date2", "End is now the same as date2");
is($ev->floating, 0, "Event isn't floating");

is($ev->floating(1), 1, "Set floating to 1");

$s  = $ev->start;
$e  = $ev->end;

is("$s", "$date1", "Start is still the same as date1. Again.");
is ($e, undef, "End if undef. Again.");
is($ev->floating, 1, "Event is floating. Again.");

