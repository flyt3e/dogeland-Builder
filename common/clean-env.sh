#!/bin/sh
if [ -n "$OLDPATH" ]; then
    export PATH="$OLDPATH"
fi
grep 'export ' $BUILDER_ROOT/scripts/set-env.sh | sed -e 's/    //g' | sed -e 's/grep.*//g' | sed -e 's/export /unset /g' | sed -e 's/unset PATH.*//g' | sed -e 's/=.*//g' | sort | uniq | uniq -u > oldenv
. ./oldenv && rm oldenv
