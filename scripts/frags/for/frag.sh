#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################
groups=() # declare an empty array; same as: declare -a groups
for i in {0..5}; do
  groups[i]="group $i"  # dynamically create element with index $i
done

# Print the resulting array's elements.
echo 1
printf '%s\n' "${groups[@]}"


# Enumerate array elements directly.
for element in "${groups[@]}"; do
  echo "$element"
done

echo 2
printf '%s\n' "${groups[@]}"
# Enumerate array elements by index.
for (( i = 0; i < ${#groups[@]}; i++ )); do
  echo "#$i: ${groups[i]}"
done
echo 3
printf '%s\n' "#$i: ${groups[@]}"
