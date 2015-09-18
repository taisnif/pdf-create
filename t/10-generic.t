#!/usr/bin/perl -w
#
# PDF::Create - Test Script
#
# Copyright 2010-     Markus Baertschi <markus@markus.org>
#
# Please see the CHANGES and Changes file for the detailed change log
#
# Generic Testing
#

BEGIN { unshift @INC, "lib", "../lib" }
use strict;
use PDF::Create;
use Test::More;

my $pdfname = $0;
$pdfname =~ s/\.t/\.pdf/;

my $pdf = PDF::Create->new(
    'filename' => "$pdfname",
    'Version'  => 1.2,
    'PageMode' => 'UseOutlines',
    'Author'   => 'Markus Baertschi',
    'Title'    => 'Testing Basic Stuff',
);

ok(defined $pdf, "Create new PDF");

ok(defined $pdf->new_page('MediaBox' => $pdf->get_page_size('A4')), "Create page root");

eval { $pdf->new_page('Xxxx' => $pdf->get_page_size('A4')) };
like($@, qr/Received invalid key/);

ok (defined $pdf->font(
        'Subtype'  => 'Type1',
        'Encoding' => 'WinAnsiEncoding',
        'BaseFont' => 'Helvetica'
    ), "Define Font" );

eval {
    $pdf->font(
        'SubType'  => 'Type1',
        'Encoding' => 'WinAnsiEncoding',
        'BaseFont' => 'Helvetica');
};
like($@, qr/Received invalid key/);

eval {
    $pdf->font(
        'Subtype'  => 'Type6',
        'Encoding' => 'WinAnsiEncoding',
        'BaseFont' => 'Helvetica');
};
like($@, qr/Received invalid value/);

eval {
    $pdf->font(
        'Subtype'  => 'Type1',
        'Encoding' => 'WinAnsiEncoding123',
        'BaseFont' => 'Helvetica');
};
like($@, qr/Received invalid value/);

eval {
    $pdf->font(
        'Subtype'  => 'Type1',
        'Encoding' => 'WinAnsiEncoding',
        'BaseFont' => 'Helvetica123');
};
like($@, qr/Received invalid value/);

ok(!$pdf->close(), "Close PDF");

done_testing();
