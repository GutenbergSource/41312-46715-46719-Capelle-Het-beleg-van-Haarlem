
use strict;

my $saxon   = "java -jar ../../../../../Tools/tei2html/tools/lib/saxon9he.jar "; # (see http://saxon.sourceforge.net/)

print "Create complete XML version of Het beleg van Haarlem...\n";

system ("$saxon BelegHaarlem.xsl BelegHaarlem.xsl > BelegHaarlem.xml");

system ("perl -S tei2html.pl -h BelegHaarlem.xml");
system ("perl -S tei2html.pl -r BelegHaarlem.xml");
system ("perl -S tei2html.pl -e BelegHaarlem.xml");
