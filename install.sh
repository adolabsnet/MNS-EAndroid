#!/usr/bin/env bash

source "assets/variables.sh"

case $1 in
  -[iI])
    sudo rm -r "/opt/${ScriptName}/"
    sudo rm "/bin/${ScriptExecutable}"
    
    if [ -e "../${ScriptName}-master/" ]; then
      sudo cp -r "../${ScriptName}-master/" "/opt/${ScriptName}/"
    else
      sudo cp -r "../${ScriptName}/" "/opt/${ScriptName}/"
    fi
    
  cat >"/bin/${ScriptExecutable}" <<-EOF
#!/usr/bin/env bash

clear && cd "/opt/${ScriptName}/"

case \$1 in
  -[hH] | "")
    sudo bash /opt/${ScriptName}/main.sh -h
    exit
  ;;
  -[sS])
    sudo bash /opt/${ScriptName}/main.sh -s
    exit
  ;;
  -[dD])
    sudo bash /opt/${ScriptName}/main.sh -d
    exit
  ;;
  -[iI])
    sudo bash /opt/${ScriptName}/main.sh -i
    exit
  ;;
  -[rR])
    sudo bash /opt/${ScriptName}/main.sh -r
    exit
  ;;
  -[cC])
    sudo bash /opt/${ScriptName}/main.sh -c
    exit
  ;;
  *)
    clear
    echo -e "\n \"\$1\" IS NOT RECOGNIZED AS AN INTERNAL COMMAND \n\n TRY \"${ScriptExecutable} -h\"\n"
    exit
  ;;
esac 2> /dev/null
EOF
    
    sudo chown -R "${UserName}" "/opt/${ScriptName}/"
    sudo chmod +x "/bin/${ScriptExecutable}"
    sudo rm -r "/opt/${ScriptName}/.git"
    sudo rm "/opt/${ScriptName}/.gitignore"
    
    echo -e "\n ${ScriptName} WAS INSTALLED \n"
  ;;
  -[uU])
    if [ -e "/opt/${ScriptName}" ] || [ -e "/bin/${ScriptExecutable}" ]; then
      sudo rm -r "/opt/${ScriptName}/"
      sudo rm -rf "/bin/${ScriptExecutable}"
      echo -e "\n ${ScriptName} WAS UNINSTALLED \n"
    else
      echo -e "\n SORRY, YOU DON'T HAVE ${ScriptName} INSTALLED \n"
    fi
  ;;
  *)
    echo -e "\n \"$1\" IS NOT RECOGNIZED AS AN INTERNAL COMMAND \n\n TRY \"sudo bash install -i (OR -u)\"\n"
    exit
  ;;
esac 2>/dev/null
