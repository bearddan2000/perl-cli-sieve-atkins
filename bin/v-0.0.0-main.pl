#!/usr/bin/env perl

sub SieveOfAtkin
{
  $limit = shift;

  print "[OUTPUT] ";
	# 2 and 3 are known to be prime
	if ($limit > 2)
	{
    print "2 ";
  }
	if ($limit > 3)
	{
    print "3 ";
  }

	# Initialise the sieve array with false values
	my @sieve = [];
	for (my $i = 0; $i < $limit; $i++)
	{
    $sieve[$i] = 0;
  }

	# Mark siev[n] is true if one of the following is true:
	# a) n = (4*x*x)+(y*y) has odd number of solutions, i.e., there exist
	# odd number of distinct pairs (x, y) that satisfy the equation and
	#	n % 12 = 1 or n % 12 = 5.
	# b) n = (3*x*x)+(y*y) has odd number of solutions and n % 12 = 7
	# c) n = (3*x*x)-(y*y) has odd number of solutions, x > y and n % 12 = 11

	for (my $x = 1; $x * $x < $limit; $x++) {
		for (my $y = 1; $y * $y < $limit; $y++) {

			# Main part of Sieve of Atkin
			my $n = (4 * $x * $x) + ($y * $y);
			if ($n <= $limit && ($n % 12 == 1 || $n % 12 == 5))
			{
        $sieve[$n] ^= 1;
      }

			$n = (3 * $x * $x) + ($y * $y);
			if ($n <= $limit && $n % 12 == 7)
			{
        $sieve[$n] ^= 1;
      }

			$n = (3 * $x * $x) - ($y * $y);
			if ($x > $y && $n <= $limit && $n % 12 == 11)
			{
        $sieve[$n] ^= 1;
      }
		}
	}

	# Mark all multiples of squares as non-prime
	for (my $r = 5; $r * $r < $limit; $r++) {
		if ($sieve[$r] == 1) {
			for (my $i = $r * $r; $i < $limit; $i += $r * $r)
			{
        $sieve[$i] = 0;
      }
		}
	}

	# Print primes using sieve[]
  for (my $a = 5; $a < $limit; $a++)
  {
    if ($sieve[$a] == 1)
  	{
      printf "%d ", $a;
    }
  }
  print "\n";
}

# Driver program
sub main
{
  my $input = 10;
  printf "[INPUT] %d\n", $input;
	&SieveOfAtkin($input);
}

&main;
