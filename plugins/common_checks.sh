#!/usr/bin/env bash

# PLUGIN NAME = COMMON CHECKS
# PLUGIN AUTHOR = MidNightSonne

#CHECK - USER HAS ROOT PERMISSIONS
function check_root() {
  if [ "$(whoami)" != "root" ]; then
    echo -e "\n - USER WITHOUT ROOT PERMISSIONS . \n"
    exit
  fi
}

#CHECK - USER HAS THE "MINIMUM REQUIRED BASH VERSION"
function check_bash() {
  BashVersion="${BASH_VERSINFO[0]}.${BASH_VERSINFO[1]}"
  MinBashVersion="4.4" # MINIMUM REQUIRED BASH VERSION
  
  compare_greater_equal() {
    awk -v n1="${1}" -v n2="${2}" 'BEGIN{if (n1>=n2) exit 0; exit 1}'
  }
  
  if ! compare_greater_equal "${BashVersion}" "${MinBashVersion}"; then
    echo -e "\n - USER WITHOUT AN ACCEPTABLE BASH VERSION ( ${BashVersion} ) "
    echo -e " - MINIMUM REQUIRED BASH VERSION: ${MinBashVersion} \n"
    exit
  fi
}

#CHECK - USE LAN IP ADDRESS OR WAN IP ADDRESS
function check_ipmd() {
  WAN=$(curl -l "https://api.ipify.org")
  LAN=$(ip addr show | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | grep -v "${WAN}")
  
  if [ "${IP_MODE}" = "WAN" ]; then
    LHOST=${WAN}
    LPORT="8080"
  else
    LHOST=${LAN}
    LPORT="4444"
  fi
}
