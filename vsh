#! /bin/bash

#this file is used to send commande correspont to netcat server

# $1 is the mode
# $2 is the host_name (localhost mainly)
# $3 is the port number
# $4 is the arch file

HOST=$2
PORT=$3

#par default , all arch files are saved in dir "archives"
ARCHIVE_DIR="archives"
ARCHIVE=$4
function main() {
#main function to load users' commande
	if [[ $1 == "-list" || $1 == "-create" || $1 == "-browse" || $1 == "-extract" ]]; then
		#enter different mode
		case $1 in
			'-list')
				modeList 
				;;
			'-create')
				modeCreate
				;;
			'-browse')
				modeBrowse
				;;
			'-extract')
				modeExtract
				;;
		esac
	else
	# actually i want to add a situation which set hostname and port as localhost and 8080 
	# then we can just enter the archive file more simplely
		echo "Usage : vsh [-list][hostname][port] \n or vsh [-browse / -create / -extract][hostname][port][archive]"
	fi
}

function send_cmd() {
	echo $1 | nc $HOST $PORT
}

function modeList() {
	#vsh -list nom_serveur port
	send_cmd "list"
}

function modeCreate() {
	#vsh -create nom_serveur port nom_create
	echo "you are in createmode"
	send_cmd "create $ARCHIVE"
}


function modeBrowse() {
	echo "you are in Browsemode"
	echo "the archive is $ARCHIVE and $HOST and $PORT"
	send_cmd "browse $ARCHIVE"
}



function modeExtract() {
	#vsh -extract nom_serveur port nom_archive
	echo "you are in extract mode"
	#default to current directory
	dir="out"

	send_cmd "extract $ARCHIVE $dir"

}

main "$@"

