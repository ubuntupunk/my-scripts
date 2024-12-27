#!/bin/bash

YELLOW="33[1;33m"
RED="33[0;31m"
ENDCOLOR="33[0m"


#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# PATCH
Apply the kernel enhancements (patch 200 lines)
# But in 4 lines of bash

#
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
function PATCH()
{

FILE="$HOME/.bashrc"

echo ""
echo -e $YELLOW"Patching file [${FILE}]..."$ENDCOLOR
echo ""

# Adding strings to .bashrc

# First we look for a string "base" to see whether or not it has already been added
LINES=`cat $FILE | grep "/dev/cgroup/cpu/user" | wc -l`
if [ "$LINES" == "0" ];
then
echo "Adding patch for performance .."
echo "if [ \"\$PS1\" ] ; then" | tee -a $FILE
echo "mkdir -m 0700 /dev/cgroup/cpu/user/\$\$" | tee -a $FILE
echo "echo \$\$ > /dev/cgroup/cpu/user/\$\$/tasks" | tee -a $FILE
echo "fi" | tee -a $FILE
else
echo "it seems that patch has been included in $FILE"
fi

FILE="/etc/rc.local"
echo ""
echo -e $YELLOW"Patching file [${FILE}]..."$ENDCOLOR
echo ""

# Adding strings to... /etc/rc.local

#First we look for a string "base" to see whether or not it has already been added
LINES=`cat $FILE | grep "/dev/cgroup/cpu/release_agent" | wc -l`
if [ "$LINES" == "0" ];
then

echo "Adding patch for performance .."
POSI=`cat $FILE | grep -n "exit 0" | sort -nr | head -n 1 | awk -F: '{print $1}'`
#echo "Is possible [$POSSIBLE]"
echo "making backup $FILE in /etc/rc.local.backup.txt"
cp /etc/rc.local /etc/rc.local.backup.txt
sed "${POSSIBLE}imkdir -p /dev/cgroup/cpu\nmount -t cgroup cgroup /dev/cgroup/cpu -o cpu\nmkdir -m 0777 /dev/cgroup/cpu/user\necho \"/usr/local/sbin/cgroup_clean\" > /dev/cgroup/cpu/release_agent" /etc/rc.local | tee /etc/rc.new.local
mv /etc/rc.new.local /etc/rc.local

#echo "#========== patch improves ============" | tee -a $FILE
#echo "mkdir -p /dev/cgroup/cpu" | tee -a $FILE
#echo "mount -t cgroup cgroup /dev/cgroup/cpu -o cpu" | tee -a $FILE
#echo "mkdir -m 0777 /dev/cgroup/cpu/user" | tee -a $FILE
#echo "echo \"/usr/local/sbin/cgroup_clean\" > /dev/cgroup/cpu/release_agent" | tee -a $FILE
#echo "#====================================" | tee -a $FILE
else
echo "It seems that patch has been included in $FILE"
fi

echo ""
echo -e $YELLOW"Giving execution permissions to [${FILE}]..."$ENDCOLOR
echo ""
sudo chmod +x $FILE

FILE="/usr/local/sbin/cgroup_clean"
echo ""
echo -e $YELLOW"Building FILE [${FILE}]..."$ENDCOLOR
echo ""
if [ -f $FILE ];
then
echo "#!/bin/sh" | tee $FILE
echo "rmdir /dev/cgroup/cpu/$*" | tee -a $FILE

else
echo "File $FILE already exists."
fi;

echo ""
echo -e $YELLOW"Giving execution permissions to... [${FILE}]..."$ENDCOLOR
echo ""
sudo chmod +x $FILE

echo "COMPLETED. Applied patch, reboot and enjoy Linux ..."

}
#-----------------------------------------------------------------------------

# Check that you are user root
if [ $USER != root ]; then
echo -e $RED"Error: you must be root."
echo -e $YELLOW"Finishing..."$ENDCOLOR
exit 0
fi

# Patching the System
PATCH

# end of 200patch.sh