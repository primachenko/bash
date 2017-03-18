#!/bin/bash
sudo cp $1 /etc/init.d
sudo chmod +x /etc/init.d/$1
sudo update-rc.d $1 defaults
