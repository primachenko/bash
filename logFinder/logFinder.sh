#!/bin/bash

search1(){
	if [ -f /var/log/$name.log ]
	then
		showFile
	else
		search2
	fi	
}

search2(){
	if [ -d /var/log/$name ]
	then	
		showDir
	else
		showSys
	fi	
}	

showSys(){
		inpTm
		cat /var/log/syslog | grep $name | grep $m'.*'$day' '$h: 
}

showFile(){
		inpTm
		cat /var/log/$name.log| grep $name | grep $m | grep $day | grep $h: 
}

showDir(){
		inpTm
		cat /var/log/$name/* | grep $name | grep $m | grep $d | grep $h:
}

inpTm(){
	echo "Введите месяц"
	read m
	echo "Введите день"
	read day
	echo "Введите час"
	read h
}

echo "Введите имя процесса"
read name
search1
