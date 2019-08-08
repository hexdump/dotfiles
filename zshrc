OLD_CLEAR="$(which clear)"

clear() {
    $OLD_CLEAR && printf '\e[3J'
}

clear

echo -n -e "\033]0; \007"
#source $HOME/Desktop/.zshrc
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
    compdef $words[1] _minimal && return 124
}

for x in $(compgen -c); do
    [ ${_comps[$x]+exists} ] && continue
    compdef _completion_loader $x;
done


#HOME="$HOME/Desktop"

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

clear-trailing-whitespace () {
    export LC_CTYPE=C
    export LANG=C
    find . -not \( -name .svn -prune -o -name .git -iname "*.(png|svg|jpg|JPG|JPEG)" -prune \) -type f -print0 | xargs -0 sed -i '' -E "s/[[:space:]]*$//"
}


alias c="clear"
alias l="ls -1"
