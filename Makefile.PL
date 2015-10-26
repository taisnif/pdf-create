#!/usr/bin/perl

use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'PDF::Create',
    VERSION_FROM     => 'lib/PDF/Create.pm',
    ABSTRACT_FROM    => 'lib/PDF/Create.pm',
    MIN_PERL_VERSION => 5.006,
    PREREQ_PM => {
        'Carp'         => 0,
        'FileHandle'   => 0,
        'Data::Dumper' => 0,
        'Scalar::Util' => 0,
    },
    TEST_REQUIRES => {
        'Test::More'      => '1.00',
        'Test::LeakTrace' => '0.14',
    },
    LICENSE    => "perl",
    dist       => { COMPRESS => "gzip", SUFFIX => "gz" },
    clean      => { FILES => '*.bak *.old mibs/*.dump *.pdf' . 'lib/*/*~ lib/*/*/*~' },
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources => {
            repository => {
                type => 'git',
                url  => 'http://github.com/manwar/pdf-create.git',
                web  => 'http://github.com/manwar/pdf-create',
            }
	}
    },
);
