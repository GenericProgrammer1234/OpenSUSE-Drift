reverse () { 
	reverse_string=""
	string=$1
	len=${#string}
	for (( i=$len-1; i>=0; i-- ))
	do
	reverse_string="$reverse_string${string:$i:1}"
	done
	echo "$reverse_string"
}

kde () {
	sudo update-alternatives --set default-xsession /usr/share/xsessions/plasma.desktop
}

plasma () {
	sudo update-alternatives --set default-xsession /usr/share/xsessions/plasma.desktop
}

gnome () {
	sudo update-alternatives --set default-xsession /usr/share/xsessions/gnome.desktop
}

switch-desktop () {
	sudo update-alternatives --set default-xsession /usr/share/xsessions/$1.desktop
}

update () {
	sudo zypper ref
	sudo zypper update
	read -p "List updates? (y/n)" list
	if [ $LIST == 'y' ]; then
		zypper list-updates --all
	else
		echo "Ok"
	fi
}
