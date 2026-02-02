#!/bin/bash

if [ -z "$1" ]; then
   echo "You have failed to pass a parameter. Please try again."
   exit 255;
fi

MYLOG=$1

function ctrlc {
   rm -rf /home/$USER/work_backup
   rm -f /home/$USER/$MYLOG
   printf "\nReceived signal Ctrl+C \n"
   exit 255
}

trap ctrlc SIGINT
echo "Timestamp before work is done $(date +"%D %T")" >> /home/$USER/$MYLOG
echo "Creating backup directory" >> /home/$USER/$MYLOG
mkdir --parents --verbose /home/$USER/work_backup

echo "Copying Files" >> /home/$USER/$MYLOG
cp --verbose /home/$USER/work/* /home/$USER/work_backup/ >> /home/$USER/$MYLOG
echo "Finished Copying Files" >> /home/$USER/$MYLOG
echo "Timestamp after work is done $(date +"%D %T")" >> /home/$USER/$MYLOG
sleep 15
