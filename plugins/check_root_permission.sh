#!/bin/bash

# PLUGIN NAME = CHECK ROOT PERMISSION
# PLUGIN AUTHOR = MidNightSonne

check_root() {
  if [ "$(whoami)" != "root" ]; then
    echo -e " - USER WITHOUT ROOT PERMISSIONS . "
  fi
}