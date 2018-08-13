#!/bin/bash
# return-test.sh

# The largest positive value a function can return is 255.

return_test ()         # Returns whatever passed to it.
{
  return $1
}

return_test 27         # o.k.
echo $?                # Returns 27.
  
return_test 255        # Still o.k.
echo $?                # Returns 255.

return_test 257        # Error!
echo $?                # Returns 1 (return code for miscellaneous error).

# =========================================================
return_test -151896    # Do large negative numbers work?
echo $?                # Will this return -151896?
                       # No! It returns 168.
#  Version of Bash before 2.05b permitted
#+ large negative integer return values.
#  It happened to be a useful feature.
#  Newer versions of Bash unfortunately plug this loophole.
#  This may break older scripts.
#  Caution!
# =========================================================

exit 0
