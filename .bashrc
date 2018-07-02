#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec

function asm() {
    nasm -f elf "${1}.nasm"; ld -m elf_i386 -s -o "${1}" "${1}.o"; "./${1}"; rm "${1}.o"; rm "${1}"
}

function brightness {
    sudo tee /sys/class/backlight/intel_backlight/brightness <<< "$1"
}

alias r="racket"

export wifi="wlp3s0"
export wifi_alt="wlp0s20u1"

function wifi-mon {
    sudo airmon-ng start $wifi_alt
}

function wifi-scan {
    sudo airodump-ng "${wifi_alt}mon"
}

function wifi-attack {
    sudo airodump-ng --bssid "$1" -c 5 --write WPAcrack "${wifi_alt}mon"
}

function wifi-replay {
    sudo aireplay-ng --deauth 100 -a "$1" "${wifi_alt}mon"
}

function wifi-crack {
    sudo aircrack-ng WPAcrack-01.cap -w /
}

function pdump {
    sudo sysctl -w net.ipv4.ip_forward=1
}

function ip-local {
    hostname -i
}

function ping-disable {
    echo 1 | sudo tee /proc/sys/net/ipv4/icmp_echo_ignore_all
}

function ping-enable {
    echo 0 | sudo tee /proc/sys/net/ipv4/icmp_echo_ignore_all
}
export GOPATH="$HOME/.go"

pre_prompt_command() {
    version="1.0.0"
    entity=$(echo $(fc -ln -0) | cut -d ' ' -f1)
    [ -z "$entity" ] && return # $entity is empty or only whitespace
    git status &> /dev/null && local project="$(basename $(git rev-parse --show-toplevel))" || local project="Terminal"
    (wakatime --write --plugin "bash-wakatime/$version" --entity-type app --project "$project" --entity "$entity" 2>&1 > /dev/null &)
}

PROMPT_COMMAND="pre_prompt_command; $PROMPT_COMMAND"
