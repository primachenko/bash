#!/bin/bash
sudo update-rc. -f $1 remove
sudo rm /etc/init.d/$1
