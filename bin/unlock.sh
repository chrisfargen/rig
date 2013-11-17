#!/bin/bash

echo "** Setting file and directory permissions..."

sudo find . \
\( -type f -exec chmod 0664 {} \; \) , \
\( -type d -exec chmod 2775 {} \; \)

echo "** Done!"

exit 0
