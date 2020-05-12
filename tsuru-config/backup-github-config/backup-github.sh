#!/usr/bin/env sh

USERNAME=""
API_KEY=""

curl -u "$USERNAME:$API_KEY" "https://api.github.com/user/repos" 2>/dev/null | grep clone_url | cut -c 38- | rev | cut -c 3- | rev | ts git@github.com: | tr -d ' ' | xargs -L1 -I % git clone %
find /Users/hexdump/github-backups -name ".git" -type d | xargs -L1 -I % git --git-dir=% pull --all
