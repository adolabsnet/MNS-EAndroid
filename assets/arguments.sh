#!/usr/bin/env bash

if [ -e "/opt/${ScriptName}" ]; then
  INSTALLED="YES"
fi

echo -e "${CNC}" && clear

case $1 in
-[hH] | "")
  echo -e "\n ## HELP : \n"
  echo " -h   - SHOW THIS MESSAGE "
  echo " -s   - START ${ScriptName} "
  echo " -d   - SHOW DISCLAIMER "
  echo " -i   - SHOW SCRIPT INFO "
  echo " -r   - UNINSTALL SCRIPT "
  echo " -c   - CHANGE WAN/LAN MODE "
  echo && exit
  ;;
-[sS])
  if [ "${INSTALLED}" != "YES" ]; then
    echo -e "\n SORRY WE CAN'T LET YOU IN RIGHT NOW - SCRIPT IS NOT INSTALLED \n"
    exit
  fi
  ;;
-[dD])
  echo -e "\n ## DISCLAIMER AND LICENSE : \n"
  echo -e " - THE AUTHOR DOES NOT HOLD ANY RESPONSIBILITY FOR THE BAD USE OF THIS TOOL. "
  echo -e " - USE '${ScriptName}' ONLY FOR EDUCATIONAL PURPOSES. "
  echo -e " - THIS PROJECT IS LICENSED UNDER THE *GPL v3.0* LICENSE. "
  echo -e "\n * REMEMBER THAT ATTACKING TARGETS WITHOUT PRIOR CONSENT IS ILLEGAL * \n"
  exit
  ;;
-[iI])
  echo -e "\n ## SCRIPT INFO : \n"
  echo -e " SCRIPT AUTHOR   : ${ScriptAuthor} "
  echo -e " SCRIPT NAME     : ${ScriptName} "
  echo -e "\n SCRIPT VERSION  : ${ScriptVersion} \n"
  exit
  ;;
-[rR])
  sudo rm -r "/opt/${ScriptName}"
  sudo rm -rf "/bin/${ScriptExecutable}"
  echo -e "\n ${ScriptName} WAS UNINSTALLED \n"
  exit
  ;;
-[cC])
  if [ "${INSTALLED}" != "YES" ]; then
    echo -e "\n - CAN'T CHANGE CONFIG - SCRIPT IS NOT INSTALLED \n"
  else
    if [ "${IP_MODE}" = LAN ]; then
      sed -i "s/IP_MODE='LAN'/IP_MODE='WAN'/g" "/opt/${ScriptName}/.config"
      echo -e "\n IP_MODE - WAN IS NOW ENABLED \n"
    elif [ "${IP_MODE}" = WAN ]; then
      sed -i "s/IP_MODE='WAN'/IP_MODE='LAN'/g" "/opt/${ScriptName}/.config"
      echo -e "\n IP_MODE - LAN IS NOW ENABLED \n"
    fi
  fi && exit
  ;;
esac
