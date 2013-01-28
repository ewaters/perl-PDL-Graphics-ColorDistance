#!/usr/bin/perl

pp_add_exported('', 'delta_e_2000');

$PDL::Graphics::ColorDistance::VERSION = '0.0.1';

pp_setversion("'$PDL::Graphics::ColorDistance::VERSION'");

pp_addpm({At=>'Top'}, <<'EOD');

=head1 NAME

PDL::Graphics::ColorDistance

=head1 VERSION

0.0.1

=head1 DESCRIPTION

=head1 SYNOPSIS

=cut

use strict;
use warnings;

use Carp;
use PDL::LiteF;

$PDL::onlinedoc->scan(__FILE__) if $PDL::onlinedoc;

EOD

pp_addhdr('
#include <math.h>
#include "color_distance.h"  /* Local decs */
'
);

pp_def('delta_e_2000',
    Pars => 'double lab1(c=3); double lab2(c=3); double [o]delta_e()',
    Code => '
        deltaE2000( $P(lab1), $P(lab2), $P(delta_e) );
    ',

    HandleBad => 1,
    BadCode => '
        /* First check for bad values */
        if ($ISBAD(lab1(c=>0)) || $ISBAD(lab1(c=>1)) || $ISBAD(lab1(c=>2)) ||
            $ISBAD(lab2(c=>0)) || $ISBAD(lab2(c=>1)) || $ISBAD(lab2(c=>2))) {
            loop (c) %{
                $SETBAD(lab1());
                $SETBAD(lab2());
            %}
            /* skip to the next triple */
        }
        else {
            deltaE2000( $P(lab1), $P(lab2), $P(delta_e) );
        }
    ',

    Doc => <<'DOCUMENTATION',

=pod

=for ref

=for usage

=cut

DOCUMENTATION
    BadDoc => <<BADDOC,

=for bad

=cut

BADDOC
);


pp_addpm(<<'EOD');

=head1 SEE ALSO

=head1 AUTHOR

=cut

EOD

pp_done();
