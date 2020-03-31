#!/bin/bash

if [ -e "/opt/${ScriptName}" ]; then
  INSTALLED="YES"
fi

case $1 in
  -[hH] | "")
    clear
    echo -e "\n ## HELP : \n"
    echo " -h   - SHOW THIS MESSAGE "
    echo " -s   - START ${ScriptName} "
    echo " -i   - CHANGE WAN/LAN MODE "
    echo " -d   - SHOW DISCLAIMER "
    echo " -v   - SHOW VERSION "
    echo " -u   - UNINSTALL SCRIPT "
    echo && exit
  ;;
  -[sS])
    clear
  ;;
  -[iI])
    clear
    if [ "${INSTALLED}" != "YES" ]; then
      echo -e "\n - CAN'T CHANGE CONFIG - SCRIPT IS NOT INSTALLED \n"
    else
      if [ "${IP_MODE}" = LAN ]; then
        sed -i "s/IP_MODE='LAN'/IP_MODE='WAN'/g" "/opt/${ScriptName}/.config"
        echo -e " IP_MODE - WAN IS NOW ENABLED \n"
        elif [ "${IP_MODE}" = WAN ]; then
        sed -i "s/IP_MODE='WAN'/IP_MODE='LAN'/g" "/opt/${ScriptName}/.config"
        echo -e " IP_MODE - LAN IS NOW ENABLED \n"
      fi
    fi && exit
  ;;
  -[dD])
    clear
    echo -e "\n ## DISCLAIMER AND LICENSE : \n"
    echo -e " - THE AUTHOR DOES NOT HOLD ANY RESPONSIBILITY FOR THE BAD USE OF THIS TOOL. "
    echo -e " - USE '${ScriptName}' ONLY FOR EDUCATIONAL PURPOSES. "
    echo -e " - THIS PROJECT IS LICENSED UNDER THE *GPL v3.0* LICENSE. "
    echo -e "\n * REMEMBER THAT ATTACKING TARGETS WITHOUT PRIOR CONSENT IS ILLEGAL * \n"
  ;;
  -[vV])
    clear
    echo -e "\n ## SCRIPT VERSION AND DETAILS : \n"
    echo -e " SCRIPT VERSION = ${ScriptVersion} "
    echo -e " CONFIG VERSION = ${ConfigVersion} "
    echo
    echo -e " SCRIPT AUTHOR = ${ScriptAuthor} "
    echo -e " SCRIPT NAME = ${ScriptName} "
    echo && exit
  ;;
  -[uU])
    clear
    sudo rm -r "/opt/${ScriptName}/" 2> /dev/null
    sudo rm -rf "/bin/${ScriptExecutable}" 2> /dev/null
    echo -e "\n ${ScriptName} WAS UNINSTALLED "
    echo && exit
  ;;
  *)
    clear
    echo -e "\n - INVALID INPUT "
    echo && exit
  ;;
esac
