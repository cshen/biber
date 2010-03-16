package Biber::Output::Base;

use Biber::Entry;
use IO::File;
use Log::Log4perl qw( :no_extra_logdie_message );
my $logger = Log::Log4perl::get_logger('main');

=encoding utf-8

=head1 NAME

Biber::Output::Base - base class for Biber output modules.

=cut

=head2 new

    Initialize a Biber::Output::Base object

=cut

sub new {
  my $class = shift;
  my $obj = shift;
  my $self;
  if (defined($obj) and ref($obj) eq 'HASH') {
    $self = bless $obj, $class;
  }
  else {
    $self = bless {}, $class;
  }
  return $self;
}

=head2 set_output_target_file

    Set the output target file of a Biber::Output::Base object
    A convenience around set_output_target so we can keep track of the
    filename

=cut

sub set_output_target_file {
  my $self = shift;
  my $file = shift;
  $self->{output_target_file} = $file;
  my $TARGET = IO::File->new($file, '>') or $logger->croak("Failed to open $file : $!");
  $self->set_output_target($TARGET);
}


=head2 set_output_target

    Set the output target of a Biber::Output::Base object

=cut

sub set_output_target {
  my $self = shift;
  my $target = shift;
  $logger->croak('Output target must be a IO::Handle object!') unless $target->isa('IO::Handle');
  $self->{output_target} = $target;
  return;
}

=head2 set_output_head

    Set the output head of a Biber::Output::Base object
    $data could be anything - the caller is expected to know.

=cut

sub set_output_head {
  my $self = shift;
  my $data = shift;
  $self->{output_data}{HEAD} = $data;
  return;
}

=head2 set_output_tail

    Set the output tail of a Biber::Output::Base object
    $data could be anything - the caller is expected to know.

=cut

sub set_output_tail {
  my $self = shift;
  my $data = shift;
  $self->{output_data}{TAIL} = $data;
  return;
}


=head2 get_output_head

    Get the output head of a Biber::Output object
    $data could be anything - the caller is expected to know.
    Mainly used in debugging

=cut

sub get_output_head {
  my $self = shift;
  return $self->{output_data}{HEAD};
}

=head2 get_output_tail

    Get the output tail of a Biber::Output object
    $data could be anything - the caller is expected to know.
    Mainly used in debugging

=cut

sub get_output_tail {
  my $self = shift;
  return $self->{output_data}{TAIL};
}


=head2 add_output_head

    Add to the head output data of a Biber::Output::Base object
    The base class method just does a string append

=cut

sub add_output_head {
  my $self = shift;
  my $data = shift;
  $self->{output_data}{HEAD} .= $data;
  return;
}

=head2 add_output_tail

    Add to the tail output data of a Biber::Output::Base object
    The base class method just does a string append

=cut

sub add_output_tail {
  my $self = shift;
  my $data = shift;
  $self->{output_data}{TAIL} .= $data;
  return;
}


=head2 set_output_entry

    Add an entry output to a Biber::Output::Base object
    The base class method just does a dump

=cut

sub set_output_entry {
  my $self = shift;
  my $entry = shift;
  $self->{output_data}{PER_ENTRY}{lc($entry->get_field('citecasekey'))} = $entry->dump;
  return;
}

=head2 get_output_entry

    Get the output data for a specific entry

=cut

sub get_output_entry {
  my $self = shift;
  my $key = shift;
  return $self->{output_data}{PER_ENTRY}{lc($key)};
}

=head2 output

    Generic base output method

=cut

sub output {
  my $self = shift;
  my $data = $self->{output_data};
  my $target = $self->{output_target};
  my $target_string = "Target"; # Default
  if ($self->{output_target_file}) {
    $target_string = $self->{output_target_file};
  }

  $logger->debug("Preparing final output using class __PACKAGE__ ...");

  print $target $data->{HEAD} or $logger->logcroak("Failure to write to $target_string: $!");
  while (my ($entry, $data) = each %{$data->{PER_ENTRY}}) {
    print $target $data or $logger->logcroak("Failure to write to $target_string: $!");
  }
  print $target $data->{TAIL} or $logger->logcroak("Failure to write to $target_string: $!");

  $logger->info("Output to $target_string");
  close $target or $logger->logcroak("Failure to close $target_string: $!");
  return;
}

=head1 AUTHORS

François Charette, C<< <firmicus at gmx.net> >>
Philip Kime C<< <philip at kime.org.uk> >>

=head1 BUGS

Please report any bugs or feature requests on our sourceforge tracker at
L<https://sourceforge.net/tracker2/?func=browse&group_id=228270>.

=head1 COPYRIGHT & LICENSE

Copyright 2009-2010 François Charette and Philip Kime, all rights reserved.

This program is free software; you can redistribute it and/or
modify it under the terms of either:

=over 4

=item * the GNU General Public License as published by the Free
Software Foundation; either version 1, or (at your option) any
later version, or

=item * the Artistic License version 2.0.

=back

=cut

1;

# vim: set tabstop=2 shiftwidth=2 expandtab:
