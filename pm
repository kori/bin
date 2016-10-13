#!/bin/sh
# Wrapper script for managing packages

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
		clean) sudo pacman -Rcns $(pacman -Qqdt) ;;

		# upgrade system
		sync) pacaur -Syu ;;

		# error
		*)
			echo "Invalid command."
			echo "Usage: pm [add|rm|grep|ls|clean|sync] [package]"
			exit 1
		;;
	esac
else
	echo "No command provided."
	echo "Usage: pm [add|rm|grep|ls|clean|sync] [package]"
	exit 1
fi
