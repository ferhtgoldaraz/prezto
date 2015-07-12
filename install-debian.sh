#!/bin/bash

# this script installs missing software for my own perfection-striving shell
# environment.
#
# It will only do what needs to be done as root
#
# For now, this script depends on debian/ubuntu stuff, like apt-get. 

#===============================================================================
# BASH BASICS
#===============================================================================

set -u  # exit script when an unset variable is referenced
set -e  # exit sctipt if when a statement returns false

#===============================================================================
# GLOBALS
#===============================================================================

installable=( tmux )
not_installed=()

#===============================================================================
# FUNCTIONS
#===============================================================================

filter_installed()
{
    for package in "${installable[@]}"; do
	type "$package" &> /dev/null || not_installed+="$package"
    done
}

#-----

install_packages()
{
    apt-get update &&                         \
    apt-get -y upgrade &&                     \

    if (( ${#not_installed[@]} != 0 )); then
        apt-get -y install "${not_installed[@]}"
    else
        echo 'all packages installed, no packages to install'
    fi
}

#===============================================================================
# MAIN
#===============================================================================

init_script()
{
    #----- Packages ------------------------------------------------------------

    filter_installed
    install_packages
}

#===============================================================================
# ENTRY POINT 
#===============================================================================

init_script

