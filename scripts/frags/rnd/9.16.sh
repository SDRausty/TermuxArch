#!/bin/bash
# seeding-random.sh: Seeding the RANDOM variable.
# v 1.1, reldate 09 Feb 2013

MAXCOUNT=25       # How many numbers to generate.
SEED=

random_numbers ()
{
local count=0
local number

while [ "$count" -lt "$MAXCOUNT" ]
do
  number=$RANDOM
  echo -n "$number "
  let "count++"
done  
}

echo; echo

SEED=1
RANDOM=$SEED      # Setting RANDOM seeds the random number generator.
echo "Random seed = $SEED"
random_numbers


RANDOM=$SEED      # Same seed for RANDOM . . .
echo; echo "Again, with same random seed ..."
echo "Random seed = $SEED"
random_numbers    # . . . reproduces the exact same number series.
                  #
                  # When is it useful to duplicate a "random" series?

echo; echo

SEED=2
RANDOM=$SEED      # Trying again, but with a different seed . . .
echo "Random seed = $SEED"
random_numbers    # . . . gives a different number series.

echo; echo

# RANDOM=$$  seeds RANDOM from process id of script.
# It is also possible to seed RANDOM from 'time' or 'date' commands.

# Getting fancy...
SEED=$(head -1 /dev/urandom | od -N 1 | awk '{ print $2 }'| sed s/^0*//)
#  Pseudo-random output fetched
#+ from /dev/urandom (system pseudo-random device-file),
#+ then converted to line of printable (octal) numbers by "od",
#+ then "awk" retrieves just one number for SEED,
#+ finally "sed" removes any leading zeros.
RANDOM=$SEED
echo "Random seed = $SEED"
random_numbers

echo; echo

exit 0
