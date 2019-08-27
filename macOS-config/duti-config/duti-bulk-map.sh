#!/usr/bin/env sh

#
# [duti-config.sh]
#
# automatically binds the "open with" application on all developer
# files to your editor of choice (in my case CLI emacs).
# Copyright (C) 2019, Liam Schumm
#

EDITOR_BUNDLE_ID="$1"

cat $2 \
    | grep -oE "^\.([a-z0-9]{2}|[a-z0-9]{3}|[a-z0-9]{4})$" \
    | tr "\n" "\0" \
    | xargs -0 -n 1 -I {} duti -s "$EDITOR_BUNDLE_ID" {} all
