use ExtUtils::MakeMaker;

my $dist = 'CGI::Builder::TT2';
my $vers = '0.02';

WriteMakefile(
    NAME      => $dist,
    VERSION   => $vers,
    ( $] ge '5.005' ) ? ( AUTHOR => 'Stefano Rodighiero',
                          ABSTRACT => 'CGI::Builder integration with TT2'
                        )
                      : (),
    PREREQ_PM => { 'CGI::Builder' => '1.0',
                   'Template'     => '2.0',
                   'Scalar::Util' => '0'
                 }
);

# Version check 

my (%opt) = map { split /=/ } @ARGV;
exit if $opt{ NO_VERSION_CHECK };

my $LWP_installed = eval { require LWP::Simple };

if ($LWP_installed) {

    my $curr_vers = LWP::Simple::get( "http://perl.4pro.net/version_check"
                                    . "?DISTRIBUTION=$dist"
                                    . "&VERSION=$vers"
                                    . "&PERL=$]-$^O" );

    exit unless defined $curr_vers;
    if ( $curr_vers == 0 ) {        # Unknown version

        print << "EOS"
    Unknown distribution: $dist.
    Please report it at http://perl.4pro.net.
EOS

    }
    elsif ( $curr_vers > $vers ) {  # Old
        print << "EOS"

   WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!

You are about to install an old $dist version! ($vers)
The current $dist version that should be available on CPAN
right now (or in a few hours) is the $current_vers.
EOS

    }
    else {                          # Ok!

        print << "EOS"
I hope you will appreciate $dist $vers.
If you have any problem with this installation,
please report it at http://perl.4pro.net
EOS

    }
}

