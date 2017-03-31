#!/bin/bash
readConfig(){
	if [ -f /home/oleg/.config/backupConf ]
	then
		user=`sed -n 1p /home/oleg/.config/backupConf`
		host=`sed -n 2p /home/oleg/.config/backupConf`
		local_path=`sed -n 3p /home/oleg/.config/backupConf`
		remote_path=`sed -n 4p /home/oleg/.config/backupConf`
		period=`sed -n 5p /home/oleg/.config/backupConf`
	else
		user=""
		host=""
		local_path=""
		remote_path=""
		period=""
		sudo touch /home/oleg/.config/backupConf
		sudo chmod o+w /home/oleg/.config/backupConf
		insertConfig
	fi
}

copy(){
	time_name=$(date +%H'-'%M'_'%d'-'%m'-'%y)
	copy_path=$local_path/$time_name
	mkdir $copy_path
	rsync -az -e "ssh -p 22" --progress $user@$host:$remote_path* $copy_path
	cd $local_path
	tar -cf $time_name.tar.gz $time_name
	rm -r $copy_path
}
 
removeTask(){
	crontab -l | grep back > tab.tmp
	VAR=`crontab -l | grep back | sed -n '1 p' | sed 's/^\(.\)/\1\\\/' | cut -c 1-20`
	sed -i "/${VAR}/d" tab.tmp;
	crontab tab.tmp
	rm tab.tmp
}

insertConfig(){
	removeTask
	user=$(whiptail --title "settings" --inputbox "enter username" 10 60 $user 3>&1 1>&2 2>&3)
	host=$(whiptail --title "settings" --inputbox "enter the hostname" 10 60 $host 3>&1 1>&2 2>&3)
	local_path=$(whiptail --title "settings" --inputbox "select path for copy" 10 60 $local_path 3>&1 1>&2 2>&3)
	remote_path=$(whiptail --title "settings" --inputbox "select path for backup" 10 60 $remote_path 3>&1 1>&2 2>&3)
	period=$(whiptail --title "settings" --inputbox "periodic for backup in hours" 10 60 $period 3>&1 1>&2 2>&3)
	echo -e "$user\n$host\n$local_path\n$remote_path\n$period" > /home/oleg/.config/backupConf
	echo "* */$period * * * bash /home/oleg/eltex/bash/backup/back.sh start" > tab.tmp
	crontab tab.tmp
	rm tab.tmp
}	

readConfig
case $1 in
	start)
		copy
		;;
	set)
		insertConfig
		;;
	stop)
		removeTask
		;;	
	help)
		echo "Предварительно должно быть настроено ssh соединение по rsa ключу"
		;;	
	*) 
		echo "Use (start | stop | set)"
		;;
esac		
