#!/bin/bash

#xsetroot -bitmap /mnt/hgfs/bashproject/welcome.jpg
whiptail --title "My Dialog" --msgbox "Welcome to my script!" 10 30
#if [ "$(id -u)" -ne 0 ]; then echo "Please run as root." >&2; exit 1; fi
##################################################################################
while true; do 
  eval `resize` 
  Menu=$(whiptail --cancel-button "Exit" --title "Menu" --menu "Choose an option" $LINES $COLUMNS $(( $LINES - 8 )) \
  "About" "Information about the program and owner." \
  "Add User" "Add a user to the system." \
  "Modify User" "Modify an existing user." \
  "List Users" "List all users on the system." \
  "Add Group" "Add a user group to the system." \
  "Modify Group" "Modify a group and its list of members." \
  "List Groups" "List all groups on the system" \
  "Disable" "Disable Account" \
  "Enable" "Enable Account" \
  "Change user's Password" "Change Password of an account" \
   3>&1 1>&2 2>&3)
  
  if [ $? != 0 ]; then exit; fi


case $Menu in
	"About")
	about="\nThis is System Admin Project For Users and Groups Services\n
	Created by: Nada Hussam Eldien Barakat\n
	Instructor: Romany Nageh\n
	(ITI-Organization)"
	whiptail --title "About" --msgbox "${about}" 20 78
	;;
	############################################
	"Add User")
	chmod +x add-user
	source ./add-user
	;;
	############################################
	"Modify User")
	chmod +x modify-user
	source ./modify-user
	;;
	############################################
	"List Users")
	chmod +x list-users
	source ./list-users
	;;
	############################################
	"Add Group")
	chmod +x add-group
	source ./add-group
	;;
	############################################
	"Modify Group")
	chmod +x modify-group
	source ./modify-group
	;;
	############################################
	"List Groups")
	chmod +x list-groups
	source ./list-groups
	;;
	############################################
	"Disable")
	chmod +x disable
	source ./disable
	;;
	############################################
	"Enable")
	chmod +x enable
	source ./enable
	;;
	############################################
	"Change user's Password")
	chmod +x change-pass
	source ./change-pass
	;;
	############################################
	 *)
	 ;;
esac
done
