#!/bin/bash

setStaticRules(){
	sudo ufw allow http
	sudo ufw allow https
	sudo ufw allow ssh
	sudo ufw allow ftp
	sudo ufw allow 3306
}

check(){
	echo 0
}

scan(){
	netstat -l | grep LISTENING | awk '{ print $8 }' > temp #; echo "EOF" >> temp
	netstat -l | grep LISTENING | awk '{ print $9 }' > temp2
}

setRulesFromFile(){
	touch temp
	touch temp2
	act="allow"
	i=1
	var=""
	while [ $i -le $(sed -n '$=' temp) ]
	do
		if test $act="allow"
			then
			echo -e "\n"
			echo $(sed -n ${i}p temp2)
			echo "allow $(sed -n ${i}p temp)"
			sudo ufw allow $(sed -n ${i}p temp)
		else
			echo -e "\n"
			echo $(sed -n ${i}p temp2)
			echo "deny $(sed ${i}p temp)"
			sudo ufw deny $(sed ${i}p temp)
		fi		
		let i=i+1
	done
	rm temp 
}
clearRules(){
	sudo ufw reset
}
show(){
	sudo ufw status verbose
}
check
case $1 in
	s)
	show
	;;
	t)
	setStaticRules
	;;
	r)
	clearRules
	;;
	d)
	scan
	act="deny"
	setRulesFromFile
	;;
	a)
	scan
	act="allow"
	setRulesFromFile
	;;
	*)
	echo "Используйте ключи t|s|c|d|a"
esac