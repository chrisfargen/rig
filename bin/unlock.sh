#!/bin/bash

echo "** Setting file and directory permissions..."

sudo find . \
\( -type f -exec chmod ug+rw,o+r {} \; \) , \
\( -type d -exec chmod u+rwx,g+rwxs,o+rx {} \; \)

echo "** Done!"

exit 0
