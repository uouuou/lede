#!/bin/sh

sleeptime=60
logfile="/tmp/clash.log"
logfile1="/var/log/clash-watchdog.file"
CLASH="/usr/bin/clash"
CLASH_CONFIG="/etc/clash"
enable=$(uci get clash.config.enabled 2>/dev/null)

clean_log(){
	logrow=$(grep -c "" ${logfile})
	logrow1=$(grep -c "" ${logfile1})
	if [ $logrow -ge 500 ];then
		cat /dev/null > ${logfile}
		echo "$curtime Log条数超限，清空处理！" >> ${logfile}
	fi
	if [ $logrow1 -ge 500 ];then
		cat /dev/null > ${logfile1}
		echo "$curtime Log条数超限，清空处理！" >> ${logfile}
	fi

}

while [ $enable -eq 1 ];
do
	curtime=`date "+%H:%M:%S"`
	echo "$curtime online! "

	if ! pidof clash>/dev/null; then
		nohup $CLASH -d $CLASH_CONFIG > /tmp/clash.log 2>&1 &
		echo "$curtime 重启服务！" >> ${logfile}
	fi

sleep ${sleeptime}
continue
done


