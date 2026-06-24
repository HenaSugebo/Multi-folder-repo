bash

#!/bin/bash
# server Health Monitoring Script
# Author: Henok Sugebo Joffe

echo "Checking server health..."
uptime
df -h
free -m
top -b -n 1 | head -n 20