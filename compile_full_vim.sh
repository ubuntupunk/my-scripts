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
		libgnome3-dev \
		libgnomeui-dev \
		libgtk2.0-dev \
		libatk1.0-dev \
		libbonoboui2-dev \
		libcairo2-dev \
		liblua5.3-dev \
        libsodium-dev \
        libx11-dev \
		libxpm-dev \
		libxt-dev \
		python3-dev \
        ruby-dev \
		git

	cd /tmp || exit
	git clone git@github.com:vim/vim.git --depth=1
	cd vim || exit
	./configure --with-features=huge \
		--enable-multibyte \
		--enable-rubyinterp \
		--enable-python3interp=yes \
		--with-python-config-dir=/usr/lib/python3.11/config-3.11-aarch64-linux-gnu/ \
		--with-python3-command=/usr/bin/python \
        --enable-perlinterp=yes \
		--enable-luainterp=yes \
		--enable-gui=gtk3 \
		--enable-cscope \
		--prefix=/usr/local
	make VIMRUNTIMEDIR=/usr/local/share/vim/vim91
	sudo make install
}

main
