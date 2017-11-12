mkdir tmp
cp *sh tmp
cd tmp
md5sum * > ../termuxarchchecksum.md5
cd ..
rm -rf tmp
