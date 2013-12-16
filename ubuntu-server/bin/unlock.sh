#!/bin/bash

echo "** Setting file and directory permissions..."

sudo find . \
\( -type f -exec sudo chmod ug+rw,o+r {} \; \) , \
\( -type d -exec sudo chmod u+rwx,g+rwxs,o+rx {} \; \)

echo "** Done!"

exit 0
