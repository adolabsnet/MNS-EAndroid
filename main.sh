#!/bin/bash

trap end_script SIGINT
trap end_script SIGTERM

source ".config"

source "assets/variables.sh"
source "assets/functions.sh"
source "assets/arguments.sh"

clear && echo -en "\\033]0;${ScriptName} | ${ScriptVersion}\\a"

check_root && check_bash

start_script && end_script
