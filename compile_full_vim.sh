#! /bin/bash

# Description:
#   Compile a full-featured Vim from source on Ubuntu/Debian distros. Based
#   on https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
#   
# Use:
#   ./compile_full_vim.sh

main(){
	echo "y" | sudo apt-get remove \
		vim \
		vim-runtime \
		gvim \
		vim-tiny \
		vim-common \
		vim-gui-common
	echo "y" | sudo apt-get install \
		libncurses5-dev \
		libgtk-3-dev \
		libatk1.0-dev \
		libcairo2-dev \
		liblua5.3-dev \
        libx11-dev \
		libxpm-dev \
		libxt-dev \
		python3-dev \
        ruby-dev \
		git \
		build-essential

	cd /tmp || exit
	git clone https://github.com/vim/vim.git --depth=1
	cd vim || exit
	./configure --with-features=huge \
		--enable-multibyte \
		--enable-rubyinterp \
		--enable-python3interp=yes \
		--with-python3-command=python3 \
        --enable-perlinterp=yes \
		--enable-luainterp=yes \
		--enable-gui=gtk3 \
		--enable-cscope \
		--prefix=/usr/local
	make VIMRUNTIMEDIR=/usr/local/share/vim/vim91
	sudo make install
}

main
