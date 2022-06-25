#!/usr/bin/env bash

function gxp () {
    if [ $# -eq 0 ]; then
	guix package; # Generates appropriate error
	return;
    fi;
    guix show "$@" 2>/dev/null 1>/dev/null
    if [ $? -eq 1 ]; then
	PKG="$(
	    guix search "$@" | \
	    	 recsel -R name -U | \
	    	 grep -v "^$" | \
	    	 fzf +s \
		     --border \
		     --preview "guix show {}" \
		     --preview-window=right:80%:wrap \
		     ;
	    )"
	[ $? -eq 0 ] && guix install "$PKG";
    else
	guix install "$@";
    fi;
}

function gxpatch () {
    patchelf "$1" --set-rpath "/run/current-system/profile/lib:\
/home/$USER/.guix-home/profile/lib\
$(guix package --list-profiles | while read -r l; do printf ":%s/lib" "$l"; done)"
    patchelf "$1" --set-interpreter "/run/current-system/profile/lib/ld-linux-x86-64.so.2"
    printf "RPATH: %s\n" "$(patchelf "$1" --print-rpath)"
    printf "LD: %s\n" "$(patchelf "$1" --print-interpreter)"
}

function run () {
    guix shell "$1" -- "$@"
}
