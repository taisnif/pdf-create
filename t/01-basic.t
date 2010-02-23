#!/usr/bin/perl -w
#
# testing basic stuff
# - open / close
# - page root / new page
# - comment
#

BEGIN { unshift @INC, "lib", "../lib" }
use strict;
use PDF::Create;
use Test::More tests => 11;

# we want the resulting pdf file to have the same name as the test
my $pdfname = $0;
$pdfname =~ s/\.t/\.pdf/;

###################################################################
#
# start testing
#

my $pdf = new PDF::Create( 'filename' => "$pdfname",
						   'Version'  => 1.2,
						   'PageMode' => 'UseOutlines',
						   'Author'   => 'Markus Baertschi',
						   'Title'    => 'Testing Basic Stuff',
						 );
ok( defined $pdf, "Create new PDF" );

ok( $pdf->add_comment("Testing Basic Stuff"), "Add a comment" );

my $root = $pdf->new_page( 'MediaBox' => $pdf->get_page_size('A4') );
ok( defined $root, "Create page root" );

# Prepare font
my $f1 = $pdf->font( 'Subtype'  => 'Type1',
					 'Encoding' => 'WinAnsiEncoding',
					 'BaseFont' => 'Helvetica'
				   );
ok( defined $f1, "Define Font" );

# Add a page which inherits its attributes from $root
my $page = $root->new_page;
ok( defined $page, "Page defined" );

# Page title and description
ok( $page->stringc( $f1, 40, 306, 700, 'PDF::Create' ),                          "stringc" );
ok( $page->stringc( $f1, 20, 306, 650, "version $PDF::Create::VERSION" ),        "stringc" );
ok( $page->stringc( $f1, 20, 306, 600, "Test: $0" ),                             "stringc" );
ok( $page->stringc( $f1, 20, 306, 550, 'Markus Baertschi (markus@markus.org)' ), "stringc" );

# Wrap up the PDF and close the file
ok( !$pdf->close(), "Close PDF" );

################################################################
#
# Check the resulting pdf for errors with pdftotext
#
if ( -x '/usr/bin/pdftotext' ) {
	if ( my $out = `/usr/bin/pdftotext $pdfname -` ) {
		ok( 1, "pdf reads fine with pdftotext" );
	} else {
		ok( 0, "pdftotext reported errors" );
		exit 1;
	}
} else {
	skip("Skip: /usr/bin/pdftotext not installed");
}

#
# TODO: Add test with ghostscript
#
#echo | gs -q -sDEVICE=bbox 06-wifi-parabola-broken.pdf
