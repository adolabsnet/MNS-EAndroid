#!/bin/bash

# PLUGIN NAME = CHECK BASH VERSION
# PLUGIN AUTHOR = MidNightSonne

BashVersion="${BASH_VERSINFO[0]}.${BASH_VERSINFO[1]}"
MinBashVersion="4.4"

compare_greater_equal() {
  awk -v n1="${1}" -v n2="${2}" 'BEGIN{if (n1>=n2) exit 0; exit 1}'
}

check_bash() {
  if ! compare_greater_equal "${BashVersion}" "${MinBashVersion}"; then
    echo -e " - USER WITHOUT AN ACCEPTABLE BASH VERSION ( ${BashVersion} ) "
    echo -e " - MINIMUM REQUIRED BASH VERSION: ${MinBashVersion} "
  fi
}
