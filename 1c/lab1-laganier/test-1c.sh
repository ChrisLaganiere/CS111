#! /bin/sh

# UCLA CS 111 Lab 1b - Test that valid commands are executed correctly.

tmp=$0-$$.tmp
mkdir "$tmp" || exit

(
cd "$tmp" || exit

cat >test.sh <<'EOF'
echo abc > a.txt

cat a.txt

echo cba > b.txt

cat b.txt

cat a.txt > b.txt

cat b.txt

echo youre a wizard harry > b.txt; echo albatross

(cat b.txt) > a.txt; echo the fear

cat a.txt

EOF

cat >test.exp <<'EOF'
abc
cba
abc
albatross
the fear
youre a wizard harry
EOF

../timetrash -t test.sh >test.out 2>test.err || exit

diff -u test.exp test.out || exit

) || exit

rm -fr "$tmp"
