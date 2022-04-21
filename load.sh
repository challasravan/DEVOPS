#!/bin/bash

##############################
#  load monitoring script    #
#             by             #
#    sravan kumar challa     #
##############################

#########################################################

trigger=10.00
date=`date`

#We set a load variable to read the current server load from /proc/loadavg and only from the first column which is the live load.

load=`cat /proc/loadavg | awk '{print $1}'`

#We set a response variable to the word “greater” if the current load is greater than our trigger that we set.

response=`echo | awk -v T=$trigger -v L=$load 'BEGIN{if ( L > T){ print "greater"}}'`

        if [[ $response = "greater" ]]; then

                echo "                          " >> /tmp/load.log
                echo "##########################" >> /tmp/load.log
                echo "$date" >> /tmp/load.log
                echo "##########################" >> /tmp/load.log
                echo "                          " >> /tmp/load.log
                echo "###High CPU Utilization Processes###" >> /tmp/load.log
                ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -20 >> /tmp/load.log
                echo "                          " >> /tmp/load.log
                echo "###High MEM Utilization Processes###" >> /tmp/load.log
                ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -20 >> /tmp/load.log
                echo "##########################" >> /tmp/load.log
        else
                echo " server load is under threshold"
        fi
