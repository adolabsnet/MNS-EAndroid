#!/bin/bash

ScriptAuthor="MidNightSonne"
ScriptName="MNS-EAndroid"
ScriptVersion="1.0-0"
ConfigVersion="1.0-0"

ScriptExecutable="mnsandroid"

Apk_Path="/var/www/html/${APK_NAME}.apk"
Index_Path="/var/www/html/index.html"
Backdoor_Path="/tmp/backdoor.sh"
Meterpreter_Path="/tmp/metasploit.sh"

UserName=$(awk -F'[/:]' '{if ($3 >= 1000 && $3 != 65534) print $1}' /etc/passwd)
