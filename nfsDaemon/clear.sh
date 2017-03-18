#!/bin/bash
sudo update-rc.d -f $1 remove
sudo rm /etc/init.d/$1
