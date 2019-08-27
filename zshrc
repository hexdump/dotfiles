[[ -f ~/.zshrc-private ]] && source ~/.zshrc-private

if [[ ! -v OLD_CLEAR ]]; then
    OLD_CLEAR="$(which clear)"
fi

clear() {
    $OLD_CLEAR && printf '\e[3J'
}

clear

title() {
    echo -n -e "\033]0;$1\007"
}

echo -n -e "\033]0; \007"

cd $HOME/Desktop
PROMPT="$ "

PATH="/Users/lschumm/Library/Python/2.7/bin:$PATH"
PATH="/Users/lschumm/Library/Python/3.7/bin:$PATH"
PATH="/usr/local/sbin:$PATH"
PATH="/Users/lschumm/.bin:$PATH"

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

[ ! -d ~/.zshcompletions ] && mkdir ~/.zshcompletions

export OTTO_COMPLETIONS_DIR="/Users/lschumm/.zshcompletions"

_minimal() {
}

_load_completion() {
    source $OTTO_COMPLETIONS_DIR/$1
}

_completion_loader() {
    [ -f $OTTO_COMPLETIONS_DIR/$words[1] ] && _load_completion $words[1] && return 124    
#    compdef $words[1] _minimal && return 124
}

for x in $(compgen -c); do
##    [ ${_comps[$x]+exists} ] && continue
    compdef _completion_loader $x;
done


#local -x HOME "$HOME/Desktop"
alias cd="HOME=~/Desktop/ cd"

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

export NVM_DIR="$HOME/.nvm"
nvm() {
    . "$(brew --prefix nvm)/nvm.sh"
    nvm
}

doctor() {
    cat ~/.zsh_history \
        | grep -v "^ls$" \
        | grep -v "^clear$" \
               > ~/.zsh_history.tmp
    mv ~/.zsh_history.tmp ~/.zsh_history
    brew update
    brew upgrade
    brew doctor
}

(otto autogenerate & ) > /dev/null 2>&1

simg() {
    convert "$2" -strip "$(date +%s).$1"
}

docker-current-container() {
    docker ps \
        | grep -o "[0-9a-z]*" \
        | head -n 2 \
        | tail -n 1
}

hash-stdin() {
    shasum | grep -o "[a-z0-9]+"
}

hash-directory() {
    find $1 -type f -print0 \
        | sort -z \
        | xargs -0 shasum \
        | hash-stdin
}

hash-file() {
    shasum $1 | grep -o "[a-z0-9]+"
}

alias c="clear"
alias l="ls -1"
export EDITOR="emacs"
#unsetopt list_ambiguous
#unsetopt menucomplete
#setopt automenu
zstyle ':completion:*' insert-unambiguous true

notify() {
    say "$2"
    osascript -e "display notification \"$2\" with title \"$1\""
}

alias sleep-seconds="sleep"

sleep-minutes() {
    for _ in {1..60}; do
        sleep-seconds "$1"
    done
}

sleep-hours() {
    for _ in {1..60}; do
        sleep-minutes "$1"
    done
}


stand-sit-walk-schedule() {
    while true; do
        notify "sit-stand-schedule" "stand!"
        echo stand
        sleep-minutes 20
        notify "sit-stand-schedule" "sit!"
        echo sit
        sleep-minutes 8
        notify "sit-stand-schedule" "walk!"
        echo walk
        sleep-minutes 2
    done
}

stand-sit-walk-schedule-lazy() {
    while true; do
        notify "sit-stand-schedule" "stand!"
        echo stand
        sleep-minutes 10
        notify "sit-stand-schedule" "sit!"
        echo sit
        sleep-minutes 20
    done
}

reset() {
    rm -rf ~/Desktop/alexandria-test/intake
    rm -rf ~/Desktop/alexandria-test/alexandria
    cp -r ~/Desktop/alexandria-test/example-intake ~/Desktop/alexandria-test/intake
    mkdir ~/Desktop/alexandria-test/alexandria
}

work-gdcapi-build-openapi() {
    docker build -t gdcapi-test -f Dockerfile.dev . && docker-compose up --abort-on-container-exit | grep 'api_1  |' | cut -c 19- | tail -n +194 > openapi.json
}

random-generate-file() {
}

if [ -z "$OLD_GIT" ]; then
    OLD_GIT="$(which git)"
fi
function git {
  if [[ "$1" == "push" && "$@" != *"--help"* ]]; then
      if "$OLD_GIT" --no-pager log -n 20 --pretty=oneline | grep -q '(step)'; then
          echo "un-squashed work!"          
      else
          "$OLD_GIT" "$@"
      fi
  elif [[ "$1" == "squash" && "$@" != *"--help"* ]]; then
      git rebase -i HEAD~"$2"
  else
      "$OLD_GIT" "$@"
  fi
}

alias e="emacs"
alias c="cd"

sarcastify-text() {
    echo $1 | sarcastify
}

sarcastify-clipboard() {
    pbpaste | sarcastify | pbcopy
}
