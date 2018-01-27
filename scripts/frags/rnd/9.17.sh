#!/bin/bash
#  random2.sh: Returns a pseudorandom number in the range 0 - 1,
#+ to 6 decimal places. For example: 0.822725
#  Uses the awk rand() function.

AWKSCRIPT=' { srand(); print rand() } '
#           Command(s)/parameters passed to awk
# Note that srand() reseeds awk's random number generator.


echo -n "Random number between 0 and 1 = "

echo | awk "$AWKSCRIPT"
# What happens if you leave out the 'echo'?

exit 0


# Exercises:
# ---------

# 1) Using a loop construct, print out 10 different random numbers.
#      (Hint: you must reseed the srand() function with a different seed
#+     in each pass through the loop. What happens if you omit this?)

# 2) Using an integer multiplier as a scaling factor, generate random numbers 
#+   in the range of 10 to 100.

# 3) Same as exercise #2, above, but generate random integers this time.
# The date command also lends itself to generating pseudorandom integer sequences.
