#!/bin/bash

# Author : Vikas


now=$(date +'%m-%d-%Y')
logFileName="startup-script-output-$now.log"
exec &> $logFileName   # To write all output to log file


declare -A SCRIPT_NAME_AND_PATHS

SCRIPT_NAME_AND_PATHS["script1.sh"]="script1.sh" # key of array is the process we need to check is it is running
SCRIPT_NAME_AND_PATHS["script2.sh"]="script2.sh" # value of the array is the path of script which will run the process 


for KEY in "${!SCRIPT_NAME_AND_PATHS[@]}" 
do

  # Get the process id of the process we want to check
  PID=`ps -ef | grep $KEY | grep -v grep | awk '{print $2}'`    
  if [ -z "$PID" ]
    then
       echo "\$PID is empty"
       nohup ./${SCRIPT_NAME_AND_PATHS[$KEY]} &
       echo "Started script ${SCRIPT_NAME_AND_PATHS[$KEY]}"
    else
       echo "$PID is NOT empty"
       #kill -9 $PID
  fi

done
