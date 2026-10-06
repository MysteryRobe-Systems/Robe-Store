#!/bin/bash
flatPakCheck(){
	
	if command -v flatpak >/dev/null 2>&1; then
     echo "Flatpak is installed!"
		return 0
		else
			echo "Flatpak is not installed please install!"
			return 1
fi
	
	
}
flatAppCheck(){
	
	if command -v $1 >/dev/null 2>&1; then
     echo "$1 is already installed"
		return 0
		else
			return 1
fi
	
	
}
