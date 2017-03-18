#!/bin/bash
sudo cp nfsDaemon /usr/sbin
sudo cp nfsDaemon /etc/init.d
sudo update-rc.d nfsDaemon start 95 2 3 4 5 . stop 5 0 1 6 .
