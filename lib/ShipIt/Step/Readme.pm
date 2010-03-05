package ShipIt::Step::Readme;

use strict;
use Pod::Readme;
use ShipIt::Util qw(slurp write_file);

use base 'ShipIt::Step';

our $VERSION = '0.01';
$VERSION = eval $VERSION;

################################################################################
# no check for dry run, because we quit anyway if we encounter an
# INSTALL / INSTALLATION section in Pod
sub run {
    my ($self, $state) = @_;
    $state->pt->current_version; #should create $self->{ver_from} for us

    # change Distribution Module
    my $dist_file = $state->pt->{ver_from};
    die "no file for distribution found", $self->{ver_from} unless ($dist_file);

    my $dist_content = slurp($dist_file);
    if ($dist_content =~ /^=head1 INSTALL/mi) {
        print "Installation Pod already created";
        return 1;
    }

    $dist_content = $self->_add_install_instructions($dist_content);
    write_file($dist_file, $dist_content);

    my $parser = Pod::Readme->new();
    $parser->parse_from_file($dist_file, 'README');

    return 1;
}

################################################################################
# put into extra sub made testing easier
sub _add_install_instructions {
    my ($self, $dist_content) = @_;
    my $install = $self->_get_instructions;
    if ($dist_content !~ s/(^=head\d NAME.*?(?=^=))/$1$install/sm) {
        die ('trying to add pod Install section after NAME Section, but there is none');
    }
    return $dist_content;
}

################################################################################
sub _build_instructions () {q~
    perl Build.PL
    ./Build
    ./Build test
    ./Build install
~;}

################################################################################
sub _make_instructions () {q~
    perl Makefile.PL
    make
    make test
    make install
~;}

################################################################################
sub _get_instructions {
    my ($self) = @_;
    my $instructions;
    if (-e 'Build.PL') {
        $instructions = $self->_build_instructions ;
    } elsif (-e 'Makefile.PL') {
        $instructions = $self->_make_instructions;
    } else {
        die ('only Build.PL and Makefile.PL are supported, but none was found');
    }

    return qq~=begin readme

=head1 INSTALLATION

To install this module, run the following commands:
$instructions
=end readme

~;}

1;

=head1 NAME

ShipIt::Step::Readme - Automatically create README for your Perl Package before releasing

=head1 VERSION

Version 0.01

=cut

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use ShipIt::Step::Readme;

    my $foo = ShipIt::Step::Readme->new();
    ...

=head1 DESCRIPTION

B<Run this after any ShipIt::Step, that edits Pod.> For example
L<ShipIt::Step::ChangePodVersion> does that to add a Pod VERSION section
to your module.

=head1 AUTHOR

Thomas Mueller, C<< <tmueller at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-shipit-step-readme at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=ShipIt-Step-Readme>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc ShipIt::Step::Readme


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=ShipIt-Step-Readme>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/ShipIt-Step-Readme>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/ShipIt-Step-Readme>

=item * Search CPAN

L<http://search.cpan.org/dist/ShipIt-Step-Readme/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2010 Thomas Mueller.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut