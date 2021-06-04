#!/bin/bash

#Amount of free memory on the system and saves it to 
#~/backups/freemem/free_mem.txt.

awk '/^Mem/ {print "Free Memory: "$4}' <(free) > ~/backups/freemem/free_mem.txt

#Disk usage and saves it to 
#~/backups/diskuse/disk_usage.txt.

df | awk '{print $1 " Used: " $5 " or " $3 "kb" }' | grep ^/dev/s > ~/backups/diskuse/disk_usage.txt

#All open files and saves it to 
#~/backups/openlist/open_list.txt.

lsof > ~/backups/openlist/open_list.txt

#File system disk space statistics and saves it to 
#~/backups/freedisk/free_disk.txt.

df | awk '{print $1 ": Available, "  $4 "kb "}' | grep ^/dev/s > ~/backups/freedisk/free_disk.txt

# End Script

