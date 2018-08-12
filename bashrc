#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

acpi

alias ls='ls --color=auto'
PS1='$ '
export PATH="$PATH:/home/lschumm/research/lime/lime"

source /usr/share/nvm/init-nvm.sh

alias clear="clear; acpi"
stty intr \^b

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

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

function external-monitor {
	 xrandr --output VGA-1 --mode 1680x1050 --pos 0x0 --rotate normal --output LVDS-1 --primary --mode 1600x900 --pos 40x1050 --rotate normal --output HDMI-3 --off --output HDMI-2 --off --output HDMI-1 --off --output DP-3 --off --output DP-2 --off --output DP-1 --off
}

function wifi-down {

	 # 
	 # sets the wifi interface to down. i can never remember
	 # all these arguments.
	 #

	 sudo ip link set dev wlp3s0 down

}