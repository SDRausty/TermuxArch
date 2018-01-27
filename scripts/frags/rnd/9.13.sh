#!/bin/bash
# brownian.sh
# Author: Mendel Cooper
# Reldate: 10/26/07
# License: GPL3

#  ----------------------------------------------------------------
#  This script models Brownian motion:
#+ the random wanderings of tiny particles in a fluid,
#+ as they are buffeted by random currents and collisions.
#+ This is colloquially known as the "Drunkard's Walk."

#  It can also be considered as a stripped-down simulation of a
#+ Galton Board, a slanted board with a pattern of pegs,
#+ down which rolls a succession of marbles, one at a time.
#+ At the bottom is a row of slots or catch basins in which
#+ the marbles come to rest at the end of their journey.
#  Think of it as a kind of bare-bones Pachinko game.
#  As you see by running the script,
#+ most of the marbles cluster around the center slot.
#+ This is consistent with the expected binomial distribution.
#  As a Galton Board simulation, the script
#+ disregards such parameters as
#+ board tilt-angle, rolling friction of the marbles,
#+ angles of impact, and elasticity of the pegs.
#  To what extent does this affect the accuracy of the simulation?
#  ----------------------------------------------------------------

PASSES=500            #  Number of particle interactions / marbles.
ROWS=10               #  Number of "collisions" (or horiz. peg rows).
RANGE=3               #  0 - 2 output range from $RANDOM.
POS=0                 #  Left/right position.
RANDOM=$$             #  Seeds the random number generator from PID
                      #+ of script.

declare -a Slots      # Array holding cumulative results of passes.
NUMSLOTS=21           # Number of slots at bottom of board.


Initialize_Slots () { # Zero out all elements of the array.
for i in $( seq $NUMSLOTS )
do
  Slots[$i]=0
done

echo                  # Blank line at beginning of run.
  }


Show_Slots () {
echo; echo
echo -n " "
for i in $( seq $NUMSLOTS )   # Pretty-print array elements.
do
  printf "%3d" ${Slots[$i]}   # Allot three spaces per result.
done

echo # Row of slots:
echo " |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|"
echo "                                ||"
echo #  Note that if the count within any particular slot exceeds 99,
     #+ it messes up the display.
     #  Running only(!) 500 passes usually avoids this.
  }


Move () {              # Move one unit right / left, or stay put.
  Move=$RANDOM         # How random is $RANDOM? Well, let's see ...
  let "Move %= RANGE"  # Normalize into range of 0 - 2.
  case "$Move" in
    0 ) ;;                   # Do nothing, i.e., stay in place.
    1 ) ((POS--));;          # Left.
    2 ) ((POS++));;          # Right.
    * ) echo -n "Error ";;   # Anomaly! (Should never occur.)
  esac
  }


Play () {                    # Single pass (inner loop).
i=0
while [ "$i" -lt "$ROWS" ]   # One event per row.
do
  Move
  ((i++));
done

SHIFT=11                     # Why 11, and not 10?
let "POS += $SHIFT"          # Shift "zero position" to center.
(( Slots[$POS]++ ))          # DEBUG: echo $POS

# echo -n "$POS "

  }


Run () {                     # Outer loop.
p=0
while [ "$p" -lt "$PASSES" ]
do
  Play
  (( p++ ))
  POS=0                      # Reset to zero. Why?
done
  }


# --------------
# main ()
Initialize_Slots
Run
Show_Slots
# --------------

exit $?

#  Exercises:
#  ---------
#  1) Show the results in a vertical bar graph, or as an alternative,
#+    a scattergram.
#  2) Alter the script to use /dev/urandom instead of $RANDOM.
#     Will this make the results more random?
#  3) Provide some sort of "animation" or graphic output
#     for each marble played.
# Jipe points out a set of techniques for generating random numbers within a range.
#  Generate random number between 6 and 30.
#   rnumber=$((RANDOM%25+6))	

#  Generate random number in the same 6 - 30 range,
#+ but the number must be evenly divisible by 3.
#   rnumber=$(((RANDOM%30/3+1)*3))

#  Note that this will not work all the time.
#  It fails if $RANDOM%30 returns 0.

#  Frank Wang suggests the following alternative:
   rnumber=$(( RANDOM%27/3*3+6 ))
#Bill Gradwohl came up with an improved formula that works for positive numbers.
#rnumber=$(((RANDOM%(max-min+divisibleBy))/divisibleBy*divisibleBy+min))
#Here Bill presents a versatile function that returns a random number between two specified values.
