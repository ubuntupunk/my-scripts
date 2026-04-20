/ bin / bash

#********************************************** #**********************************************

# sources.sh # Sources.sh

# Para generar un sources.list a medida # To generate a sources.list as

# 3 Agosto 2009 # August 3, 2009

#********************************************** #**********************************************

# Requisitos: sudo aptitude install dialog # Requirements: sudo aptitude install dialog

# Futura version: sqlite base de datos con repos # Future version: sqlite database with repos

# Tutorial sobre dialog: http://www.linuxjournal.com/article/2807 # Tutorial on dialog: http://www.linuxjournal.com/article/2807

# Fichero donde generar el sources.list temporal # File which generate temporary sources.list

FICHERO="/tmp/sources.list" FILE = "/ tmp / sources.list"

rm $FICHERO rm $ FILE

#---------------------------------------------- #----------------------------------------------

# Funcion para a├▒adir repositorios principales # Function to add a ├ ▒ major repositories

#---------------------------------------------- #----------------------------------------------

function addrepoBranches addrepoBranches function

{ (

repo=$1 repo = $ 1

sistema=$2 system = $ 2

# segun el sistema ir a uno u otro repo # Under the scheme either go to repo

# TODO: el pais, ahora toma los de servidores espa├▒a # TODO: the country now takes the server espa ├ ▒ a

# if la cadena no es vacia la a├▒adimos # If the string is not empty the a ├ ▒ adimen

if (true) then if (true) then

echo "#############################################################">> $FICHERO echo "################################################ #############">> $ FILE

echo "################### OFFICIAL UBUNTU REPOS ###################">> $FICHERO OFFICIAL UBUNTU "################### echo $ FILE ###################">> REPOS

echo "#############################################################">> $FICHERO echo "################################################ #############">> $ FILE

echo "###### Ubuntu Main Repos" >> $FICHERO Main "###### Ubuntu Repos echo ">> $ FILE

echo "deb http://es.archive.ubuntu.com/ubuntu/ $sistema $repo" >> $FICHERO echo "deb $ http://es.archive.ubuntu.com/ubuntu/ system $ repo">> $ FILE

echo "deb-src http://es.archive.ubuntu.com/ubuntu/ $sistema $repo" >> $FICHERO echo "deb-src http://es.archive.ubuntu.com/ubuntu/ $ system $ repo">> $ FILE

fi fi

} )

#--- # ---

#------------------------------------------ #------------------------------------------

# Funcion para a├▒adir repositorios updates # Function to add repositories for updates ├ ▒

#------------------------------------------ #------------------------------------------

function addrepoUpdate addrepoUpdate function

{ (

repo=$1 repo = $ 1

sistema=$2 system = $ 2

main=$3 main = $ 3

#echo "Recibido $sistema $repo $main" # echo "Received $ system $ repo $ main"

echo "deb http://es.archive.ubuntu.com/ubuntu/ $sistema-$repo $main" >> $FICHERO echo "deb http://es.archive.ubuntu.com/ubuntu/ $ system-$ repo $ main">> $ FILE

echo "deb-src http://es.archive.ubuntu.com/ubuntu/ $sistema-$repo $main" >> $FICHERO echo "deb-src http://es.archive.ubuntu.com/ubuntu/ $ system-$ repo $ main">> $ FILE

} )

#---- #----

#----------------------------------------- #-----------------------------------------

# Funcion para a├▒adir repositorio partner # Function to add a ├ ▒ partner repository

#----------------------------------------- #-----------------------------------------

function addRepoPartner addRepoPartner function

{ (

repo=$1 repo = $ 1

sistema=$2 system = $ 2

#echo "Recibido $sistema $repo" # echo "Received $ system $ repo"

# if no es vacio a├▒adimos las cadenas # If not empty to adimen chains ├ ▒

if [ $repo == "\"1\"" ]; if [$ repo == "\" 1 \ ""];

then then

echo "###### Ubuntu Partner Repo" >> $FICHERO Ubuntu Repo "###### Partner echo ">> $ FILE

echo "deb http://archive.canonical.com/ubuntu $sistema partner" >> $FICHERO echo "deb $ http://archive.canonical.com/ubuntu partner system">> $ FILE

echo "deb-src http://archive.canonical.com/ubuntu $sistema partner" >> $FICHERO echo "deb-src $ http://archive.canonical.com/ubuntu partner system">> $ FILE

fi fi

} )

#----- #-----

#---------------------------------------------- #----------------------------------------------

# Funcion para a├▒adir repositorios de terceros # Function to add ├ ▒ a third-party repositories

#---------------------------------------------- #----------------------------------------------

function addrepo3Party addrepo3Party function

{ (

repos=$1 repos = $ 1

sistema=$2 system = $ 2

#echo "Recibido.... $sistema $repos" # echo "Received .... $ system $ repos"

for i in $repos for i in $ repos

do do

item=$i item = $ i

#echo "itemxxx: $item" # echo "itemxxx: $ item"

case $i in case $ i in

\"1\") \ "1 \")

## repositorio de Abiword # # Repository Abiword

#echo "A├æADE ABIWORD..." # echo "A ├ SFDA AbiWord ..."

#### Abiword - http://www.abisource.com/ # # # # Abiword - http://www.abisource.com/

## Run this command: sudo apt-key adv --keyserver # # Run this command: sudo apt-key adv - keyserver

keyserver.ubuntu.com --recv-keys 2382D57E keyserver.ubuntu.com - recv-keys 2382D57E

#deb http://ppa.launchpad.net/abiword-stable/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/abiword-stable/ubuntu

echo "#### Abiword - http://www.abisource.com/" >> $FICHERO echo "#### Abiword - http://www.abisource.com/ ">> $ FILE

echo "## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 2382D57E" >> $FICHERO echo "# # Run this command: sudo apt-key adv - keyserver.ubuntu.com keyserver - recv-keys 2382D57E">> $ FILE

echo "deb http://ppa.launchpad.net/abiword-stable/ubuntu $SISTEMA main" >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/abiword-stable/ubuntu main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"2\") \ "2 \")

## repositorio de Amarok 2 # # Repository Amarok 2

#echo "A├æADE AMAROK2..." # echo "A ├ SFDA AMAROK2 ..."

#### Amarok 2 - Project Neon -http://amarok.kde.org/wiki/User:Apachelogger/Project_Neon # # # # Amarok 2 - Project Neon-http: / / amarok.kde.org / wiki / User: apachelogger / Project_Neon

## Run this command: gpg --keyserver subkeys.pgp.net --recv 0F7992B0 && gpg --export --armor 0F7992B0  | sudo apt-key add - # # Run this command: gpg - keyserver subkeys.pgp.net - recv 0F7992B0 & & gpg - export - armor 0F7992B0 | sudo apt-key add --

#deb http://ppa.launchpad.net/project-neon/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/project-neon/ubuntu

echo "#### Amarok 2 - Project Neon - http://amarok.kde.org/wiki/User:Apachelogger/Project_Neon" >> $FICHERO echo "#### Amarok 2 - Project Neon - http://amarok.kde.org/wiki/User:Apachelogger/Project_Neon ">> $ FILE

echo "## Run this command: gpg --keyserver subkeys.pgp.net --recv 0F7992B0 && gpg --export --armor 0F7992B0  | sudo apt-key add -" >> $FICHERO echo "# # Run this command: gpg - keyserver subkeys.pgp.net - recv 0F7992B0 & & gpg - export - armor 0F7992B0 | sudo apt-key add -">> $ FILE

echo "deb http://ppa.launchpad.net/project-neon/ubuntu $SISTEMA main" >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/project-neon/ubuntu main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"3\") \ "3 \")

## repositorio de AWN # # Repository AWN

#### AWN (Avant Window Navigator) Testing Packages - http://awn-project.org/ # # # # AWN (Avant Window Navigator) Testing Packages - http://awn-project.org/

## Run this command: gpg --keyserver subkeys.pgp.net --recv BF810CD5 && gpg --export --armor BF810CD5 | sudo apt-key add - # # Run this command: gpg - keyserver subkeys.pgp.net - recv BF810CD5 & & gpg - export - armor BF810CD5 | sudo apt-key add --

#deb http://ppa.launchpad.net/awn-testing/ppa/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/awn-testing/ppa/ubuntu

#echo "A├æADE AWN..." # echo "A ├ AEADE AWN ..."

echo "#### AWN (Avant Window Navigator) Testing Packages - http://awn-project.org/" >> $FICHERO echo "#### AWN (Avant Window Navigator) Testing Packages - http://awn-project.org/ ">> $ FILE

echo "## Run this command: gpg --keyserver subkeys.pgp.net --recv BF810CD5 && gpg --export --armor BF810CD5 | sudo apt-key add -" >> $FICHERO echo "# # Run this command: gpg - keyserver subkeys.pgp.net - recv BF810CD5 & & gpg - export - armor BF810CD5 | sudo apt-key add -">> $ FILE

echo "deb http://ppa.launchpad.net/awn-testing/ppa/ubuntu $SISTEMA main" >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/awn-testing/ppa/ubuntu main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"4\") \ "4 \")

## repositorio de Cairo # # Repository Cairo

#### Cairo Dock - http://www.cairo-dock.org/ww_page.php?p=AccueilΓî⌐=en # # # # Cairo Dock - http://www.cairo-dock.org/ww_page.php?p=AccueilΓî ⌐ = en

## Run this command: wget -q http://repository.cairo-dock.org/ubuntu/cairo-dock.gpg -O- | sudo apt-key add - # # Run this command: wget-q http://repository.cairo-dock.org/ubuntu/cairo-dock.gpg-O-| sudo apt-key add --

#deb http://repository.cairo-dock.org/ubuntu jaunty cairo-dock jaunty http://repository.cairo-dock.org/ubuntu deb cairo-dock

#echo "A├æADE CAIRO DOCK..." # echo "A ├ SFDA CAIRO DOCK ..."

echo "#### Cairo Dock - http://www.cairo-dock.org/ww_page.php?p=AccueilΓî⌐=en" >> $FICHERO echo "#### Cairo Dock - http://www.cairo-dock.org/ww_page.php?p=AccueilΓî ⌐ = en ">> $ FILE

echo "## Run this command: wget -q http://repository.cairo-dock.org/ubuntu/cairo-dock.gpg -O- | sudo apt-key add -" >> $FICHERO echo "# # Run this command: wget-q http://repository.cairo-dock.org/ubuntu/cairo-dock.gpg-O-| sudo apt-key add -">> $ FILE

echo "deb http://repository.cairo-dock.org/ubuntu $SISTEMA cairo-dock" >> $FICHERO echo "deb $ SYSTEM http://repository.cairo-dock.org/ubuntu cairo-dock">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"5\") \ "5 \")

## repositorio de CHROMIUM # # Repository CHROMIUM

#### Chromium Project - http://code.google.com/chromium/ # # # # Chromium Project - http://code.google.com/chromium/

## Run this command: gpg --keyserver subkeys.pgp.net --recv 4E5E17B5 && gpg --export --armor 4E5E17B5 | sudo apt-key add - # # Run this command: gpg - keyserver subkeys.pgp.net - recv 4E5E17B5 & & gpg - export - armor 4E5E17B5 | sudo apt-key add --

#deb http://ppa.launchpad.net/chromium-daily/ppa/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/chromium-daily/ppa/ubuntu

#echo "A├æADE CHROMIUM..." # echo "A ├ SFDA CHROMIUM ..."

echo "#### Chromium Project - http://code.google.com/chromium/" >> $FICHERO echo "#### Chromium Project - http://code.google.com/chromium/ ">> $ FILE

echo "## Run this command: gpg --keyserver subkeys.pgp.net --recv 4E5E17B5 && gpg --export --armor 4E5E17B5 | sudo apt-key add -" >> $FICHERO echo "# # Run this command: gpg - keyserver subkeys.pgp.net - recv 4E5E17B5 & & gpg - export - armor 4E5E17B5 | sudo apt-key add -">> $ FILE

echo "deb http://ppa.launchpad.net/chromium-daily/ppa/ubuntu $SISTEMA main" >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/chromium-daily/ppa/ubuntu main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"6\") \ "6 \")

## repositorio de Conky # # Repository Conky

#### Conky - https://launchpad.net/conky # # # # Conky - https: / / launchpad.net / conky

## Run this command: gpg --keyserver subkeys.pgp.net --recv 95628707 && gpg --export --armor 95628707 | sudo apt-key add - # # Run this command: gpg - keyserver subkeys.pgp.net - recv 95628707 & & gpg - export - armor 95628707 | sudo apt-key add --

#deb http://ppa.launchpad.net/norsetto/ppa/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/norsetto/ppa/ubuntu

#echo "A├æADE CONKY..." # echo "A ├ SFDA conky ..."

echo "#### Conky - https://launchpad.net/conky" >> $FICHERO echo "#### Conky - https: / / launchpad.net / conky ">> $ FILE

echo "## Run this command: gpg --keyserver subkeys.pgp.net --recv 95628707 && gpg --export --armor 95628707 | sudo apt-key add -" >> $FICHERO echo "# # Run this command: gpg - keyserver subkeys.pgp.net - recv 95628707 & & gpg - export - armor 95628707 | sudo apt-key add -">> $ FILE

echo "deb http://ppa.launchpad.net/norsetto/ppa/ubuntu $SISTEMA main" >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/norsetto/ppa/ubuntu main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"7\") \ "7 \")

## repositorio de Exaile # # Repository for Exaile

#echo "A├æADE EXAILE..." # echo "A ├ SFDA exaile ..."

#### Exaile - http://www.exaile.org # # # # Exaile - http://www.exaile.org

## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 43CBFCC0 # # Run this command: sudo apt-key adv - keyserver.ubuntu.com keyserver - recv-keys 43CBFCC0

#deb http://ppa.launchpad.net/exaile-devel/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/exaile-devel/ubuntu

echo "#### Exaile - http://www.exaile.org" >> $FICHERO echo "#### Exaile - http://www.exaile.org ">> $ FILE

echo "## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 43CBFCC0" >> $FICHERO echo "# # Run this command: sudo apt-key adv - keyserver.ubuntu.com keyserver - recv-keys 43CBFCC0">> $ FILE

echo "deb http://ppa.launchpad.net/exaile-devel/ubuntu $SISTEMA main" >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/exaile-devel/ubuntu main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"8\") \ "8 \")

## repositorio de FREENX # # Repository for FreeNX

#echo "A├æADE FREENX..." # echo "A ├ SFDA FreeNX ..."

#### FreeNX  - http://freenx.berlios.de/ # # # # FreeNX - http://freenx.berlios.de/

## Run this command: gpg --keyserver subkeys.pgp.net --recv D018A4CE && gpg --export --armor D018A4CE | sudo apt-key add - # # Run this command: gpg - keyserver subkeys.pgp.net - recv D018A4CE & & gpg - export - armor D018A4CE | sudo apt-key add --

#deb http://ppa.launchpad.net/freenx-team/ppa/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/freenx-team/ppa/ubuntu

echo "#### FreeNX  - http://freenx.berlios.de/" >> $FICHERO echo "#### FreeNX - http://freenx.berlios.de/ ">> $ FILE

echo "## Run this command: gpg --keyserver subkeys.pgp.net --recv D018A4CE && gpg --export --armor D018A4CE | sudo apt-key add -" >> $FICHERO echo "# # Run this command: gpg - keyserver subkeys.pgp.net - recv D018A4CE & & gpg - export - armor D018A4CE | sudo apt-key add -">> $ FILE

echo "deb http://ppa.launchpad.net/freenx-team/ppa/ubuntu $SISTEMA main" >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/freenx-team/ppa/ubuntu main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"9\") \ "9 \")

## repositorio de GNOME_COLORS # # Repository GNOME_COLORS

#### GNOME-Colors PPA - https://edge.launchpad.net/~gnome-colors-packagers/+archive/ppa # # # # GNOME-Colors PPA - https: / / edge.launchpad.net / ~ gnome-colors-packagers / + archive / ppa

## Run this command: sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2d79f61be8d31a30 # # Run this command: sudo apt-key adv - recv-keys - keyserver keyserver.ubuntu.com 2d79f61be8d31a30

#deb http://ppa.launchpad.net/gnome-colors-packagers/ppa/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/gnome-colors-packagers/ppa/ubuntu

#echo "A├æADE GNOME-COLORS..." # echo "A ├ SFDA GNOME-COLORS ..."

echo "#### GNOME-Colors PPA - https://edge.launchpad.net/~gnome-colors-packagers/+archive/ppa" >> $FICHERO "#### echo-Colors GNOME PPP - https: / / edge.launchpad.net / ~ gnome-colors-packagers / + archive / ppa ">> $ FILE

echo "## Run this command: sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2d79f61be8d31a30"  >> $FICHERO echo "# # Run this command: sudo apt-key adv - recv-keys - keyserver keyserver.ubuntu.com 2d79f61be8d31a30">> $ FILE

echo "deb http://ppa.launchpad.net/gnome-colors-packagers/ppa/ubuntu $SISTEMA main"  >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/gnome-colors-packagers/ppa/ubuntu main">> $ FILE

echo ""  >> $FICHERO echo "">> $ FILE

;; ;;

\"10\") \ "10 \")

## repositorio de GOOGLE LINUX # # Repository GOOGLE LINUX

#echo "A├æADE GOOGLE LINUX..." # echo "A ├ SFDA GOOGLE LINUX ..."

#### Google Linux Software Repositories - http://www.google.com/linuxrepositories/index.html # # # # Google Linux Software Repositories - http://www.google.com/linuxrepositories/index.html

## Run this command: wget -q https://dl-ssl.google.com/linux/linux_signing_key.pub -O- | sudo apt-key add - # # Run this command: wget-q https: / / dl-ssl.google.com/linux/linux_signing_key.pub-O-| sudo apt-key add --

#deb http://dl.google.com/linux/deb/ stable non-free deb http://dl.google.com/linux/deb/ stable non-free

#### Google Linux Software Repositories (testing) - http://www.google.com/linuxrepositories/index.html # # # # Google Linux Software Repositories (testing) - http://www.google.com/linuxrepositories/index.html

## Run this command: wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add  - # # Run this command: wget-q-O - https: / / dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add --

#deb http://dl.google.com/linux/deb/ testing non-free deb http://dl.google.com/linux/deb/ testing non-free

echo "#### Google Linux Software Repositories - http://www.google.com/linuxrepositories/index.html" >> $FICHERO echo "#### Google Linux Software Repositories - http://www.google.com/linuxrepositories/index.html ">> $ FILE

echo "## Run this command: wget -q https://dl-ssl.google.com/linux/linux_signing_key.pub -O- | sudo apt-key add -" >> $FICHERO echo "# # Run this command: wget-q https: / / dl-ssl.google.com/linux/linux_signing_key.pub-O-| sudo apt-key add -">> $ FILE

echo "deb http://dl.google.com/linux/deb/ stable non-free" >> $FICHERO echo "deb http://dl.google.com/linux/deb/ stable non-free">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

echo "#### Google Linux Software Repositories (testing) - http://www.google.com/linuxrepositories/index.html" >> $FICHERO echo "#### Google Linux Software Repositories (testing) - http://www.google.com/linuxrepositories/index.html ">> $ FILE

echo "## Run this command: wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add  -" >> $FICHERO echo "# # Run this command: wget-q-O - https: / / dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -">> $ FILE

echo "#deb http://dl.google.com/linux/deb/ testing non-free" >> $FICHERO echo "deb http://dl.google.com/linux/deb/ testing non-free">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"11\") \ "11 \")

## repositorio de GNOME-DO # # Repository GNOME-DO

#echo "A├æADE GNOME-DO..." # echo "A ├ SFDA GNOME-DO ..."

#### Gnome-Do - http://do.davebsd.com/ # # # # Gnome-Do - http://do.davebsd.com/

## Run this command: gpg --keyserver subkeys.pgp.net --recv 77558DD0 && gpg --export --armor 77558DD0  | sudo apt-key add - # # Run this command: gpg - keyserver subkeys.pgp.net - recv 77558DD0 & & gpg - export - armor 77558DD0 | sudo apt-key add --

#deb http://ppa.launchpad.net/do-core/ppa/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/do-core/ppa/ubuntu

echo "#### Gnome-Do - http://do.davebsd.com/" >> $FICHERO echo "#### Gnome-Do - http://do.davebsd.com/ ">> $ FILE

echo "## Run this command: gpg --keyserver subkeys.pgp.net --recv 77558DD0 && gpg --export --armor 77558DD0  | sudo apt-key add -" >> $FICHERO echo "# # Run this command: gpg - keyserver subkeys.pgp.net - recv 77558DD0 & & gpg - export - armor 77558DD0 | sudo apt-key add -">> $ FILE

echo "deb http://ppa.launchpad.net/do-core/ppa/ubuntu $SISTEMA main" >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/do-core/ppa/ubuntu main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"12\") \ "12 \")

## repositorio de MEDIBUNTU # # Medibuntu repository

#echo "A├æADE MEDIBUNTU..." # echo "A ├ SFDA Medibuntu ..."

#### Medibuntu - http://www.medibuntu.org/ # # # # Medibuntu - http://www.medibuntu.org/

## Run this command: sudo apt-get update && sudo apt-get install medibuntu-keyring && sudo apt-get update # # Run this command: sudo apt-get update & & sudo apt-get install medibuntu-keyring & & sudo apt-get update

#deb http://packages.medibuntu.org/ jaunty free non-free deb http://packages.medibuntu.org/ jaunty free non-free

echo "#### Medibuntu - http://www.medibuntu.org/" >> $FICHERO echo "#### Medibuntu - http://www.medibuntu.org/ ">> $ FILE

echo "## Run this command: sudo apt-get update && sudo apt-get install medibuntu-keyring && sudo apt-get update" >> $FICHERO echo "# # Run this command: sudo apt-get update & & sudo apt-get install medibuntu-keyring & & sudo apt-get update">> $ FILE

echo "deb http://packages.medibuntu.org/ $SISTEMA free non-free" >> $FICHERO echo "deb $ SYSTEM http://packages.medibuntu.org/ free non-free">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"13\") \ "13 \")

## repositorio de OPENOFFICE 3.0 # # Repository for OpenOffice 3.0

#echo "A├æADE OPENOFFICE 3.0..." # echo "A ├ SFDA OpenOffice 3.0 ..."

#### OpenOffice.org 3.0 - https://launchpad.net/~openoffice-pkgs/+archive # # # # OpenOffice.org 3.0 - https: / / launchpad.net / ~ openoffice-pkgs / + archive

## Run this command: gpg --keyserver subkeys.pgp.net --recv 247D1CFF && gpg --export --armor 247D1CFF  | sudo apt-key add - # # Run this command: gpg - keyserver subkeys.pgp.net - recv 247D1CFF & & gpg - export - armor 247D1CFF | sudo apt-key add --

#deb http://ppa.launchpad.net/openoffice-pkgs/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/openoffice-pkgs/ubuntu

echo "#### OpenOffice.org 3.0 - https://launchpad.net/~openoffice-pkgs/+archive" >> $FICHERO echo "#### OpenOffice.org 3.0 - https: / / launchpad.net / ~ openoffice-pkgs / + archive ">> $ FILE

echo "## Run this command: gpg --keyserver subkeys.pgp.net --recv 247D1CFF && gpg --export --armor 247D1CFF  | sudo apt-key add -" >> $FICHERO echo "# # Run this command: gpg - keyserver subkeys.pgp.net - recv 247D1CFF & & gpg - export - armor 247D1CFF | sudo apt-key add -">> $ FILE

echo "deb http://ppa.launchpad.net/openoffice-pkgs/ubuntu $SISTEMA main" >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/openoffice-pkgs/ubuntu main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"14\") \ "14 \")

## repositorio de OPERA # # Repository OPERA

#echo "A├æADE OPERA..." # echo "A ├ SFDA OPERA ..."

#### Opera - http://www.opera.com/ # # # # Opera - http://www.opera.com/

## Run this command: sudo wget -O - http://deb.opera.com/archive.key | sudo apt-key add - # # Run this command: sudo wget-O - http://deb.opera.com/archive.key | sudo apt-key add --

#deb http://deb.opera.com/opera/ lenny non-free http://deb.opera.com/opera/ deb lenny non-free

#### Opera (Beta) - http://www.opera.com/ # # # # Opera (Beta) - http://www.opera.com/

## Run this command: sudo wget -O - http://deb.opera.com/archive.key | sudo apt-key add - # # Run this command: sudo wget-O - http://deb.opera.com/archive.key | sudo apt-key add --

#deb http://deb.opera.com/opera-beta/ lenny non-free http://deb.opera.com/opera-beta/ deb lenny non-free

#### Opera (Snapshot) - http://www.opera.com/ # # # # Opera (Snapshot) - http://www.opera.com/

## Run this command: sudo wget -O - http://deb.opera.com/archive.key | sudo apt-key add - # # Run this command: sudo wget-O - http://deb.opera.com/archive.key | sudo apt-key add --

#deb http://deb.opera.com/opera-snapshot/ lenny non-free http://deb.opera.com/opera-snapshot/ deb lenny non-free

echo "#### Opera - http://www.opera.com/" >> $FICHERO echo "#### Opera - http://www.opera.com/ ">> $ FILE

echo "## Run this command: sudo wget -O - http://deb.opera.com/archive.key | sudo apt-key add -" >> $FICHERO echo "# # Run this command: sudo wget-O - http://deb.opera.com/archive.key | sudo apt-key add -">> $ FILE

echo "deb http://deb.opera.com/opera/ $SISTEMA non-free" >> $FICHERO echo "deb $ SYSTEM http://deb.opera.com/opera/ non-free">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

echo "#### Opera (Beta) - http://www.opera.com/" >> $FICHERO echo "#### Opera (Beta) - http://www.opera.com/ ">> $ FILE

echo "## Run this command: sudo wget -O - http://deb.opera.com/archive.key | sudo apt-key add -" >> $FICHERO echo "# # Run this command: sudo wget-O - http://deb.opera.com/archive.key | sudo apt-key add -">> $ FILE

echo "deb http://deb.opera.com/opera-beta/ $SISTEMA non-free" >> $FICHERO echo "deb $ SYSTEM http://deb.opera.com/opera-beta/ non-free">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

echo "#### Opera (Snapshot) - http://www.opera.com/" >> $FICHERO echo "#### Opera (Snapshot) - http://www.opera.com/ ">> $ FILE

echo "## Run this command: sudo wget -O - http://deb.opera.com/archive.key | sudo apt-key add -" >> $FICHERO echo "# # Run this command: sudo wget-O - http://deb.opera.com/archive.key | sudo apt-key add -">> $ FILE

echo "deb http://deb.opera.com/opera-snapshot/ $SISTEMA non-free" >> $FICHERO echo "deb $ SYSTEM http://deb.opera.com/opera-snapshot/ non-free">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"15\") \ "15 \")

## repositorio de ORACLE # # Repository ORACLE

#### Oracle Database 10g Express Edition  - http://oss.oracle.com # # # # Oracle Database 10g Express Edition - http://oss.oracle.com

## Run this command: wget http://oss.oracle.com/el4/RPM-GPG-KEY-oracle -O- | sudo apt-key add - # # Run this command: wget http://oss.oracle.com/el4/RPM-GPG-KEY-oracle-O-| sudo apt-key add --

#deb http://oss.oracle.com/debian unstable main non-free http://oss.oracle.com/debian deb unstable main non-free

#echo "A├æADE ORACLE..." # echo "A ├ SFDA ORACLE ..."

echo "#### Oracle Database 10g Express Edition - http://oss.oracle.com" >> $FICHERO echo "#### Oracle Database 10g Express Edition - http://oss.oracle.com ">> $ FILE

echo "## Run this command: wget http://oss.oracle.com/el4/RPM-GPG-KEY-oracle -O- | sudo apt-key add -" >> $FICHERO echo "# # Run this command: wget http://oss.oracle.com/el4/RPM-GPG-KEY-oracle-O-| sudo apt-key add -">> $ FILE

echo "deb http://oss.oracle.com/debian unstable main non-free" >> $FICHERO echo "deb unstable main http://oss.oracle.com/debian non-free">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"16\") \ "16 \")

## repositorio de PLAYDEB # # Repository Playdeb

#### Playdeb - http://www.playdeb.net/ # # # # Playdeb - http://www.playdeb.net/

## Run this command: wget -O- http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add - # # Run this command: wget-O-http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add --

#deb http://archive.getdeb.net/ubuntu jaunty-getdeb-testing games deb http://archive.getdeb.net/ubuntu jaunty-getdeb-testing games

#echo "A├æADE PLAYDEB..." # echo "A ├ SFDA Playdeb ..."

echo "#### Playdeb - http://www.playdeb.net/" >> $FICHERO echo "#### Playdeb - http://www.playdeb.net/ ">> $ FILE

echo "## Run this command: wget -O- http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -" >> $FICHERO echo "# # Run this command: wget-O-http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -">> $ FILE

echo "deb http://archive.getdeb.net/ubuntu $SISTEMA-getdeb-testing games" >> $FICHERO echo "deb $ http://archive.getdeb.net/ubuntu SYSTEM-getdeb-testing games">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"17\") \ "17 \")

## repositorio de PLAYONLINUX # # Repository PlayonLinux

#### PlayOnLinux - http://www.playonlinux.com # # # # PlayOnLinux - http://www.playonlinux.com

## Run this command: sudo apt-get update && sudo apt-get install playonlinux # # Run this command: sudo apt-get update & & sudo apt-get install PlayOnLinux

#deb http://deb.playonlinux.com/ jaunty main jaunty main deb http://deb.playonlinux.com/

#echo "A├æADE PLAYONLINUX..." # echo "A ├ SFDA PlayonLinux ..."

echo "#### PlayOnLinux - http://www.playonlinux.com" >> $FICHERO echo "#### PlayOnLinux - http://www.playonlinux.com ">> $ FILE

echo "## Run this command: sudo apt-get update && sudo apt-get install playonlinux" >> $FICHERO echo "# # Run this command: sudo apt-get update & & sudo apt-get install PlayOnLinux">> $ FILE

echo "deb http://deb.playonlinux.com/ $SISTEMA main" >> $FICHERO echo "deb $ SYSTEM http://deb.playonlinux.com/ main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"18\") \ "18 \")

## repositorio de SKYPE # # Repository SKYPE

#### Skype - http://www.skype.com # # # # Skype - http://www.skype.com

## Run this command: gpg --keyserver pgp.mit.edu --recv-keys 0xd66b746e && gpg --export --armor 0xd66b746e  | sudo apt-key add - # # Run this command: gpg - keyserver pgp.mit.edu - recv-keys 0xd66b746e & & gpg - export - armor 0xd66b746e | sudo apt-key add --

#deb http://download.skype.com/linux/repos/debian/ stable non-free deb http://download.skype.com/linux/repos/debian/ stable non-free

#echo "A├æADE SKYPE..." # echo "A ├ SFDA SKYPE ..."

echo "#### Skype - http://www.skype.com " >> $FICHERO echo "#### Skype - http://www.skype.com ">> $ FILE

echo "## Run this command: gpg --keyserver pgp.mit.edu --recv-keys 0xd66b746e && gpg --export --armor 0xd66b746e | sudo apt-key add -" >> $FICHERO echo "# # Run this command: gpg - keyserver pgp.mit.edu - recv-keys 0xd66b746e & & gpg - export - armor 0xd66b746e | sudo apt-key add -">> $ FILE

echo "deb http://download.skype.com/linux/repos/debian/ stable non-free" >> $FICHERO echo "deb http://download.skype.com/linux/repos/debian/ stable non-free">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"19\") \ "19 \")

## repositorio de SMPLAYER # # Repository SMPlayer

#### SMPlayer - http://smplayer.sourceforge.net/ # # # # SMPlayer - http://smplayer.sourceforge.net/

## Run this command: gpg --keyserver subkeys.pgp.net --recv A58BCAE3 && gpg --export --armor A58BCAE3  | sudo apt-key add - # # Run this command: gpg - keyserver subkeys.pgp.net - recv A58BCAE3 & & gpg - export - armor A58BCAE3 | sudo apt-key add --

#deb http://ppa.launchpad.net/rvm/ppa/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/rvm/ppa/ubuntu

echo "#### SMPlayer - http://smplayer.sourceforge.net/" >> $FICHERO echo "#### SMPlayer - http://smplayer.sourceforge.net/ ">> $ FILE

echo "## Run this command: gpg --keyserver subkeys.pgp.net --recv A58BCAE3 && gpg --export --armor A58BCAE3  | sudo apt-key add -" >> $FICHERO echo "# # Run this command: gpg - keyserver subkeys.pgp.net - recv A58BCAE3 & & gpg - export - armor A58BCAE3 | sudo apt-key add -">> $ FILE

echo "deb http://ppa.launchpad.net/rvm/ppa/ubuntu $SISTEMA main" >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/rvm/ppa/ubuntu main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"20\") \ "20 \")

## repositorio de TERMINATOR # # Repository TERMINATOR

#### Terminator - http://www.tenshu.net/terminator/ # # # # Terminator - http://www.tenshu.net/terminator/

## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1BD3A65C # # Run this command: sudo apt-key adv - keyserver.ubuntu.com keyserver - recv-keys 1BD3A65C

#deb http://ppa.launchpad.net/gnome-terminator/ppa/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/gnome-terminator/ppa/ubuntu

echo "#### Terminator - http://www.tenshu.net/terminator/" >> $FICHERO echo "#### Terminator - http://www.tenshu.net/terminator/ ">> $ FILE

echo "## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1BD3A65C" >> $FICHERO echo "# # Run this command: sudo apt-key adv - keyserver.ubuntu.com keyserver - recv-keys 1BD3A65C">> $ FILE

echo "deb http://ppa.launchpad.net/gnome-terminator/ppa/ubuntu $SISTEMA main" >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/gnome-terminator/ppa/ubuntu main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"21\") \ "21 \")

## repositorio de UBUNTU TWEAK # # Repository UBUNTU TWEAK

#### Ubuntu Tweak - http://ubuntu-tweak.com/ # # # # Ubuntu Tweak - http://ubuntu-tweak.com/

## Run this command: gpg --keyserver subkeys.pgp.net --recv 0624A220 && gpg --export --armor 0624A220  | sudo apt-key add - # # Run this command: gpg - keyserver subkeys.pgp.net - recv 0624A220 & & gpg - export - armor 0624A220 | sudo apt-key add --

#deb http://ppa.launchpad.net/tualatrix/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/tualatrix/ubuntu

echo "#### Ubuntu Tweak - http://ubuntu-tweak.com/" >> $FICHERO echo "#### Ubuntu Tweak - http://ubuntu-tweak.com/ ">> $ FILE

echo "## Run this command: gpg --keyserver subkeys.pgp.net --recv 0624A220 && gpg --export --armor 0624A220  | sudo apt-key add -" >> $FICHERO echo "# # Run this command: gpg - keyserver subkeys.pgp.net - recv 0624A220 & & gpg - export - armor 0624A220 | sudo apt-key add -">> $ FILE

echo "deb http://ppa.launchpad.net/tualatrix/ubuntu $SISTEMA main " >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/tualatrix/ubuntu main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"22\") \ "22 \")

## repositorio de VIRTUALBOX # # Repository for VirtualBox

#### VirtualBox - http://www.virtualbox.org # # # # VirtualBox - http://www.virtualbox.org

## Run this command: wget -q http://download.virtualbox.org/virtualbox/debian/sun_vbox.asc -O- | sudo apt-key add - # # Run this command: wget-q http://download.virtualbox.org/virtualbox/debian/sun_vbox.asc-O-| sudo apt-key add --

#deb http://download.virtualbox.org/virtualbox/debian intrepid non-free deb http://download.virtualbox.org/virtualbox/debian intrepid non-free

echo "#### VirtualBox - http://www.virtualbox.org" >> $FICHERO echo "#### VirtualBox - http://www.virtualbox.org ">> $ FILE

echo "## Run this command: wget -q http://download.virtualbox.org/virtualbox/debian/sun_vbox.asc -O- | sudo apt-key add -" >> $FICHERO echo "# # Run this command: wget-q http://download.virtualbox.org/virtualbox/debian/sun_vbox.asc-O-| sudo apt-key add -">> $ FILE

echo "deb http://download.virtualbox.org/virtualbox/debian $SISTEMA non-free " >> $FICHERO echo "deb $ SYSTEM http://download.virtualbox.org/virtualbox/debian non-free">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"23\") \ "23 \")

## repositorio de VLC # # Repository VLC

#### VLC & X264 - https://launchpad.net/~kow/+archive/ppa # # # # VLC & X264 - https: / / launchpad.net / ~ kow / + archive / ppa

## Run this command: gpg --keyserver subkeys.pgp.net --recv 2F021AC1 && gpg --export --armor 2F021AC1 | sudo apt-key add - # # Run this command: gpg - keyserver subkeys.pgp.net - recv 2F021AC1 & & gpg - export - armor 2F021AC1 | sudo apt-key add --

#deb http://ppa.launchpad.net/kow/ppa/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/kow/ppa/ubuntu

#### VLC Media Player  - http://www.videolan.org/vlc/ # # # # VLC Media Player - http://www.videolan.org/vlc/

## Run this command: gpg --keyserver keyserver.ubuntu.com --recv-keys 40130828 && gpg --export -a 40130828 | sudo apt-key add - # # Run this command: gpg - keyserver keyserver.ubuntu.com - recv-keys 40130828 & & gpg - export-a 40130828 | sudo apt-key add --

#deb http://ppa.launchpad.net/c-korn/ppa/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/c-korn/ppa/ubuntu

echo "#### VLC & X264 - https://launchpad.net/~kow/+archive/ppa" >> $FICHERO echo "#### VLC & X264 - https: / / launchpad.net / ~ kow / + archive / ppa ">> $ FILE

echo "## Run this command: gpg --keyserver subkeys.pgp.net --recv 2F021AC1 && gpg --export --armor 2F021AC1 | sudo apt-key add -" >> $FICHERO echo "# # Run this command: gpg - keyserver subkeys.pgp.net - recv 2F021AC1 & & gpg - export - armor 2F021AC1 | sudo apt-key add -">> $ FILE

echo "deb http://ppa.launchpad.net/kow/ppa/ubuntu $SISTEMA main" >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/kow/ppa/ubuntu main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

echo "#### VLC Media Player  - http://www.videolan.org/vlc/" >> $FICHERO echo "#### VLC Media Player - http://www.videolan.org/vlc/ ">> $ FILE

echo "## Run this command: gpg --keyserver keyserver.ubuntu.com --recv-keys 40130828 && gpg --export -a 40130828 | sudo apt-key add -" >> $FICHERO echo "# # Run this command: gpg - keyserver keyserver.ubuntu.com - recv-keys 40130828 & & gpg - export-a 40130828 | sudo apt-key add -">> $ FILE

echo "deb http://ppa.launchpad.net/c-korn/ppa/ubuntu $SISTEMA main " >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/c-korn/ppa/ubuntu main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"24\") \ "24 \")

## repositorio de WINE # # Repository WINE

#### Wine - http://www.winehq.org/ # # # # Wine - http://www.winehq.org/

## Run this command: wget -q http://wine.budgetdedicated.com/apt/387EE263.gpg -O- | sudo apt-key add - # # Run this command: wget-q http://wine.budgetdedicated.com/apt/387EE263.gpg-O-| sudo apt-key add --

#deb http://wine.budgetdedicated.com/apt jaunty main http://wine.budgetdedicated.com/apt jaunty main deb

echo "#### Wine - http://www.winehq.org/" >> $FICHERO echo "#### Wine - http://www.winehq.org/ ">> $ FILE

echo "## Run this command: wget -q http://wine.budgetdedicated.com/apt/387EE263.gpg -O- | sudo apt-key add -" >> $FICHERO echo "# # Run this command: wget-q http://wine.budgetdedicated.com/apt/387EE263.gpg-O-| sudo apt-key add -">> $ FILE

echo "deb http://wine.budgetdedicated.com/apt $SISTEMA main" >> $FICHERO echo "deb $ SYSTEM http://wine.budgetdedicated.com/apt main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"25\") \ "25 \")

## repositorio de XBMC # # Repository XBMC

#### XBMC Media Center - http://xbmc.org/ # # # # XBMC Media Center - http://xbmc.org/

## Run this command: gpg --keyserver subkeys.pgp.net --recv 91E7EE5E && gpg --export --armor 91E7EE5E | sudo apt-key add - # # Run this command: gpg - keyserver subkeys.pgp.net - recv 91E7EE5E & & gpg - export - armor 91E7EE5E | sudo apt-key add --

#deb http://ppa.launchpad.net/team-xbmc/ppa/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/team-xbmc/ppa/ubuntu

echo "#### XBMC Media Center - http://xbmc.org/" >> $FICHERO echo "#### XBMC Media Center - http://xbmc.org/ ">> $ FILE

echo "## Run this command: gpg --keyserver subkeys.pgp.net --recv 91E7EE5E && gpg --export --armor 91E7EE5E | sudo apt-key add -" >> $FICHERO echo "# # Run this command: gpg - keyserver subkeys.pgp.net - recv 91E7EE5E & & gpg - export - armor 91E7EE5E | sudo apt-key add -">> $ FILE

echo "#deb http://ppa.launchpad.net/team-xbmc/ppa/ubuntu $SISTEMA main" >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/team-xbmc/ppa/ubuntu main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"26\") \ "26 \")

#### KDE 4.3 RC 3 - http://www.kubuntu.org/news/kde-4.2.98 # # # # KDE 4.3 RC 3 - http://www.kubuntu.org/news/kde-4.2.98

## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8AC93F7A # # Run this command: sudo apt-key adv - keyserver.ubuntu.com keyserver - recv-keys 8AC93F7A

#deb http://ppa.launchpad.net/kubuntu-ppa/ppa/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/kubuntu-ppa/ppa/ubuntu

echo "#### KDE 4.3 RC 3 - http://www.kubuntu.org/news/kde-4.2.98" >> $FICHERO "#### echo KDE 4.3 RC 3 - http://www.kubuntu.org/news/kde-4.2.98 ">> $ FILE

echo "## Run this command: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8AC93F7A" >> $FICHERO echo "# # Run this command: sudo apt-key adv - keyserver.ubuntu.com keyserver - recv-keys 8AC93F7A">> $ FILE

echo "#deb http://ppa.launchpad.net/kubuntu-ppa/ppa/ubuntu $SISTEMA main" >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/kubuntu-ppa/ppa/ubuntu main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"27\") \ "27 \")

#### Mozilla Daily Build Team - http://edge.launchpad.net/~ubuntu-mozilla-daily/+archive/ppa # # # # Mozilla Daily Build Team - http://edge.launchpad.net/ ubuntu mozilla-daily / + archive / ppa

## Run this command: gpg --keyserver subkeys.pgp.net --recv-key 247510BE && gpg --armor --export  247510BE | sudo apt-key add - # # Run this command: gpg - keyserver subkeys.pgp.net - recv-key 247510BE & & gpg - armor - export 247510BE | sudo apt-key add --

#deb http://ppa.launchpad.net/ubuntu-mozilla-daily/ppa/ubuntu jaunty main jaunty main deb http://ppa.launchpad.net/ubuntu-mozilla-daily/ppa/ubuntu

echo "#### Mozilla Daily Build Team - http://edge.launchpad.net/~ubuntu-mozilla-daily/+archive/ppa" >> $FICHERO Mozilla Daily "#### echo Build Team - http://edge.launchpad.net/ ubuntu mozilla-daily / + archive / ppa ">> $ FILE

echo "## Run this command: gpg --keyserver subkeys.pgp.net --recv-key 247510BE && gpg --armor --export  247510BE | sudo apt-key add -" >> $FICHERO echo "# # Run this command: gpg - keyserver subkeys.pgp.net - recv-key 247510BE & & gpg - armor - export 247510BE | sudo apt-key add -">> $ FILE

echo "deb http://ppa.launchpad.net/ubuntu-mozilla-daily/ppa/ubuntu $SISTEMA main" >> $FICHERO echo "deb $ SYSTEM http://ppa.launchpad.net/ubuntu-mozilla-daily/ppa/ubuntu main">> $ FILE

echo "" >> $FICHERO echo "">> $ FILE

;; ;;

\"28\") \ "28 \")

## repositorio de Node.js LTS # # Repository Node.js LTS

echo "#### Node.js LTS - https://deb.nodesource.com/" >> $FICHERO

echo "## Run: curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -" >> $FICHERO

echo "deb https://deb.nodesource.com/node_lts.x $SISTEMA main" >> $FICHERO

echo "" >> $FICHERO

;; ;;

\"29\") \ "29 \")

## repositorio de Docker CE # # Repository Docker CE

echo "#### Docker CE - https://download.docker.com/linux/ubuntu" >> $FICHERO

echo "## Run: curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg" >> $FICHERO

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $SISTEMA stable" >> $FICHERO

echo "" >> $FICHERO

;; ;;

\"30\") \ "30 \")

## repositorio de Visual Studio Code # # Repository Visual Studio Code

echo "#### Visual Studio Code - https://packages.microsoft.com/repos/code" >> $FICHERO

echo "## Run: wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/ && rm packages.microsoft.gpg" >> $FICHERO

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code $SISTEMA main" >> $FICHERO

echo "" >> $FICHERO

;; ;;

esac esac

done done

} )

#------ #------

#--- Empieza lo bueno --- # --- Begin --- good

DIALOG=${DIALOG=dialog} DIALOG = $ (DIALOG = dialog)

tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$ tempfile = `tempfile 2> / dev / null` | | tempfile = / tmp / test $ $

trap "rm -f $tempfile" 0 1 2 5 15 trap "rm-f $ tempfile" 0 1 2 5 15

#------------------ #------------------

# Dialogo Sistema # Dialogue System

#------------------ #------------------

dialog --backtitle "Release Selection" \ dialog - backtitle "Release Selection" \

--radiolist "Select release type:" 15 80 4 \ - radiolist "Select release type:" 15 80 4 \

1 "Hardy 8.04" off \ 1 "Hardy 8.04" off \

2 "Intrepid 8.10" off \ 2 "Intrepid 8.10" off \

3 "Jaunty 9.04" on \ 3 "Jaunty 9.04" on \

4 "Karmic 9.10" off 2> $tempfile 4 "Karmic 9.10" off \

5 "Noble 24.04" on 2> $tempfile

retval=$? retval = $?

#echo "retval es $retval"; # echo "$ retval retval is";

choice=`cat $tempfile` 

case $retval in 

0) 

#echo "$retval";; 

;;

1) 

clear 

exit;; 

#echo "CANCEL pressed.";; 

255) 

clear 

exit;; 

#echo "ESC pressed.";; 

esac 

#echo "Selection: $choice"

SYSTEM="" 

case $choice in 

1)

SYSTEM="hardy";; 

2)

SYSTEM="intrepid";; 

3)

SYSTEM="jaunty";; 

4)

SYSTEM="karmic";;

5)

SYSTEM="noble";;

esac 
#echo "Sistema: $SYSTEM" 

#---------------------- 

Dialogue Branches

#----------------------

dialog --backtitle "branches" \ 

--checklist "Select:" 15 80 4 \ 
1 Main on \ 

2 Restricted on \ 

3 Universe on \ 

4 Multiverse on 2> $tempfile 

retval=$? 

choice=`cat $tempfile` 

case $retval in 

0) 

#echo "$retval";; 

;; 

1) 

clear 

exit;; 

#echo "CANCEL pressed.";; 

255) 

clear 

exit;; 

#echo "ESC pressed.";; 

esac

#echo "Selection: $choice" 

selection="" 

for i in $choice; 

do 

#echo "item: [$i]" 

# Here the ideal would be to consult a database (eg sqlite) and retrieve the chains, but good at the moment it

# We do bareback

item=$i 

case $i in 

\"1\") 

#Main repository

#echo "Adiendo repository Main $SYSTEM ..."; 

selection=$selection" main"; 

;;

\"2\")

## repositorio de Restricted # # Repository Restricted

#echo "Adiendo repository Restricted $SYSTEM ..."

selection=$selection "restricted"; 

;;

\"3\") 

#Repository Universe

#echo "Adiendo repository Universe $SYSTEM ..."

selection=$selection "universe"; 

;;

\"4\") \ 

# Multiverse repository

#echo "Adiendo repositorio Multiverse $SYSTEM ..."

selection = $selection "multiverse";

;;

esac

done

# echo "select is $selection;

addrepoBranches "$selection" $ SYSTEM "

#-------------------------------

# Dialogue Ubuntu Updates

#------------------------------- 

dialog --backtitle "updates" \ 

--checklist "Select:" 15 80 4 \

1 Security on \ 

2 Updates on \ 

3 Proposed on \ 

4 Backports on 2> $tempfile 

retval=$? 

choice=`cat $tempfile` 

case $retval in 

0) 

#echo "$retval";;

;; 

1) 

clear 

exit;; 

#echo "CANCEL pressed.";; 

255) 

clear 

exit;; 

#echo "ESC pressed.";; 

esac

#echo "Updates: $choice"


echo "###### Ubuntu Repos Update" >> FILE

#echo "Selection is $ selector

for i in $choice; 

do 

item=$i 

case $ i in

\"1 \")

addrepoUpdate "security" $ SYSTEM "$ selection"

;;

\"2 \")

addrepoUpdate "updates" $ SYSTEM "$ selection"

;;

\"3 \")

addrepoUpdate "proposed" $ SYSTEM "$ selection"

;;

\"4 \")

addrepoUpdate "backports" $ SYSTEM "$ selection"

;;

esac

done

#------------------------

#Dialogue Ubuntu Partner

#------------------------

dialog - backtitle Ubuntu Repo Partner "\

--checklist "Select:" 15 80 1 \ 

1 "Repo Ubuntu Partner" off 2> $ tempfile

retval = $?

choice = `cat $ tempfile`

case $ retval in

0)

# echo "$ retval";

;;

1)

clear

exit;;

# echo "CANCEL pressed.";

255)

clear

exit;;

# echo "ESC pressed.";

esac

# echo "Partner: $ choice"

addRepoPartner $ choice "$ SYSTEM"

#--------------------------------- #---------------------------------

# Dialogue repository of third

#--------------------------------- #---------------------------------

dialog - backtitle "3rd parties" \

--checklist "Select repos: \ N3RD Parties" 20 80 30 \

1 Abiword off \

2 "Amarok 2" off \

AWN off 3 \

4 Cairo off \

Chromium 5 off \

6 Conky off \

7 Exaile off \

8 FreeNX off \

9 GNOME-colors off 9 \

10 Google-Linux off \

11 Gnome-do off \

13 "OpenOffice 3.0" off \

14 operas off \

Oracle 15 off \

17 PlayOnLinux off \

SMPlayer 19 off \

Terminator 20 off \

26 "KDE 4.3 RC" off \

27 "Mozilla daily build" off \

28 "Node.js LTS" off \

29 "Docker CE" off \

30 "Visual Studio Code" off 2> $ tempfile

retval = $?

choice = `cat $ tempfile`

case $ retval in

0)

# echo "$ retval";

;;

1)

clear

exit;;

# echo "CANCEL pressed.";

255)

clear

exit;; exit;;

# echo "ESC pressed.";

esac

echo "3rd party: $ choice"

echo "">> $ FILE

echo "##############################################################" 

>> $FICHERO >> $ FILE

echo "##################### UNOFFICIAL  REPOS ######################" 

>> $ FILE

 echo "##############################################################"

>> $ FILE

echo "">> $ FILE

Binary "###### echo 3rd Party Repos ">> $ FILE

echo "">> $ FILE

echo "">> $ FILE

addrepo3Party "$ choice" "$ SYSTEM"

#----------------------------- #-----------------------------

Dialogue informational message

#----------------------------- #-----------------------------

dialog - msgbox "The file has been generated in $ FILE" 15 80 \

clear

echo "Please use this script, courtesy of Ubuntu Life

(http://www.ubuntulife.net - August 2009) "

echo "The file has been generated in $ FILE."

echo "Do not forget to take a backup of / etc / apt / sources.list

" disaster avoidance :-) "

echo ""

echo "(Ubuntu - Strength and Honor)"

echo ""

exit;

# END OF SCRIPT 
