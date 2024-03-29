#!/bin/bash
WHITE='\033[0;37m' 
BLUE='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
BWhite='\033[1;37m' 
NC='\033[0m'
if ! ls -l $HOME/goinfre | grep "francinette-image" &> /dev/null; then
	git clone https://github.com/WaRtr0/francinette-image.git $HOME/goinfre/francinette-image
fi

chmod +x $HOME/goinfre/francinette-image/run.sh

if ! ls -l $HOME/goinfre/francinette-image | grep "francinette.tar" &> /dev/null; then
	if hostname | grep "42lyon.fr" &> /dev/null; then
 		if ls -l /sgoinfre/goinfre/Perso/mmorot/share | grep "francinette.tar" &> /dev/null; then
   			echo -e "${BLUE}[Francinette] ${WHITE}Copy of francinette.tar (${BWhite}/sgoinfre/goinfre/Perso/mmorot/share${WHITE})"
      			cp /sgoinfre/goinfre/Perso/mmorot/share/francinette.tar $HOME/goinfre/francinette-image/
	 		echo -e "${BLUE}[Francinette] ${WHITE}Copy ${GREEN}OK"
   		fi
 	fi
fi

if ! ls -l $HOME/goinfre/francinette-image | grep "francinette.tar" &> /dev/null; then
	docker build -t francinette-image $HOME/goinfre/francinette-image
	docker image save francinette-image > $HOME/goinfre/francinette-image/francinette.tar
fi
if ls -l $HOME/goinfre/francinette-image | grep "francinette.tar" &> /dev/null; then
	docker load < $HOME/goinfre/francinette-image/francinette.tar
fi

source $HOME/goinfre/francinette-image/utils/install_zshrc.sh


echo -e "${BLUE}[Francinette] ${GREEN}Installation completed!\n${WHITE}Use the ${BWhite}paco${WHITE} or ${BWhite}francinette${WHITE} commands in your project folder."

exec "$SHELL"

