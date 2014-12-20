#!/bin/bash

cd /app/etc
/bin/bash makeSphinxIndex.sh all
/usr/bin/searchd --config /app/etc/sphinx.conf --nodetach
