#!/bin/sh
# Wrapper script for managing packages

usage() {
	echo $1
	echo "Usage: pm [add|rm|grep|ls|clean|sync] [package]"
	exit 1
}

if [ -n "$1" ]; then
	case "$1" in
		# add packages
		add) shift 1; pacaur -S $@ ;;

		# remove packages
		rm) shift 1; sudo pacman -Rcns $@ ;;

		# find packages
		grep) shift 1; pacaur -Ss $@ ;;

		# list packages
		ls) pacman -Q ;;

		# remove orphans
		clean)
			orphans=$(pacman -Qqdt)
			if [ -z "$orphans" ]; then
				echo "No orphans to remove."
			else
				sudo pacman -Rcns $(pacman -Qqdt)
			fi ;;

		# upgrade system
		sync) pacaur -Syu ;;

		# error
		*) usage "Invalid command."
		;;
	esac
else
	usage "No command provided."
fi
