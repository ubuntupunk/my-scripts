#!/bin/bash
ans=$(zenity  --list  --width=350 --height=400 --text "Initial Ubuntu Tasks" --checklist  --column "Select" --column "Options" TRUE "Uninstall Mono" TRUE "Install Déjà Dup" TRUE "Install Restricted Extras & Codecs" TRUE "Install MS Core Fonts" TRUE "Install FileZilla FTP" TRUE "Install Wine" TRUE "Install VLC Media Player" TRUE "Install K3B" TRUE "Enable 5.1 Surround Sound" --separator=":");

arr=$(echo $ans | tr "\:" "\n")

for x in $arr
do
	if [ $x = "Mono" ]
	then
		echo "=================================================="
		echo "Uninstalling Mono..."
		echo "=================================================="
		sudo apt-get -y remove --purge mono-common libmono0
	fi
	if [ "$x" = "Install Déjà Dup" ]
	then
		echo "=================================================="
		echo "Installing Déjà Dup"
		echo "=================================================="
		sudo apt-get -y install deja-dup
	fi
	if [ $x = "Restricted" ]
	then
		echo "=================================================="
		echo "Installing Restricted Extras & Codecs"
		echo "=================================================="
		sudo apt-get -y install ubuntu-restricted-extras
	fi
	if [ $x = "Fonts" ]
	then
		echo "=================================================="
		echo "Installing Fonts"
		echo "=================================================="
		sudo apt-get -y install ttf-mscorefonts-installer && sudo fc-cache -fv
	fi
	if [ $x = "VLC" ]
	then
		echo "=================================================="
		echo "Installing VLC Media Player"
		echo "=================================================="
		sudo apt-get -y install vlc
	fi
	if [ $x = "K3B" ]
	then
		echo "=================================================="
		echo "Installing K3B"
		echo "=================================================="
		sudo apt-get -y install k3b
	fi
	if [ $x = "Wine" ]
	then
		echo "=================================================="
		echo "Installing Wine"
		echo "=================================================="
		sudo apt-get -y install wine
	fi
	if [ $x = "FileZilla" ]
	then
		echo "=================================================="
		echo "Installing FileZilla FTP"
		echo "=================================================="
		sudo apt-get -y install filezilla
	fi
	if [ $x = "Sound" ]
	then
		echo "=================================================="
		echo "Enabling 5.1 Playback"
		echo "=================================================="
		sudo perl -pi -w -e 's/\; default-sample-channels \= 2/default-sample-channels \= 6/g;' /etc/pulse/daemon.conf
	fi
done

