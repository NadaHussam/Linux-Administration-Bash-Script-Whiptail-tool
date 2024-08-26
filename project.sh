#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then echo "Please run as root." >&2; continue 1; fi

while true; do
command=$(whiptail --cancel-button "Exit" --title "Bash Project" --menu "Choose an option" 25 78 16 \
"Add User" "Add a user to the system." \
"Modify User" "Modify an existing user." \
"List Users" "List all users on the system." \
"Add Group" "Add a user group to the system." \
"Modify Group" "Modify a group and its list of members." \
"List Groups" "List all groups on the system." \
"Disable" "Disable Account" \
"Enable" "Enable Account" \
"Change Password" "Change Password of an account." \
"About" "Information about the program." \
3>&1 1>&2 2>&3)

if [ $? != 0 ]; then exit; fi

case $command in
##################################################
  "Add User")
    username=$(whiptail --inputbox "Enter username:" \
    8 39 "" --title "Add User" 3>&1 1>&2 2>&3)
    if [ $? != 0 ]; then continue; fi
    useradd ${username}
    ;;
##################################################
  "Modify User")
    username=$(whiptail --inputbox "Enter username:" \
    8 39 "" --title "Modify User" 3>&1 1>&2 2>&3)
    if [ $? != 0 ]; then continue; fi
    
    opt=$(whiptail --title "Modify User" --radiolist \
    "Choose an option" 20 78 4 \
    "Comment" "The new value of the user's password file comment field." ON \
    "GID" "The group name or number of the user's new initial login group." OFF \
    "Groups" "A list of supplementary groups which the user is also a member of." OFF \
    "UID" "The new numerical value of the user's ID." OFF \
    3>&1 1>&2 2>&3)
    if [ $? != 0 ]; then continue; fi
    
    case $opt in
      "Comment")
        comment=$(whiptail --inputbox "Enter Comment:" \
        8 39 "" --title "Modify User" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then continue; fi
        
        usermod -c "${comment}" ${username}
        ;;
     #########################################
       "GID")
        gid=$(whiptail --inputbox "Enter new GID:" \
        8 39 "" --title "Modify User" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then continue; fi
        
        usermod -g ${gid} ${username}
        ;;
     #########################################
       "Groups")
        groups=$(id -Gn ${username} | tr " " ",")
        new_g=$(whiptail --inputbox "Enter user groups:" \
        8 39 "${groups}" --title "Modify User" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then continue; fi
        usermod -G ${new_g} ${username}
        ;;
     #########################################
       "UID")
        uid=$(whiptail --inputbox "Enter new UID:" \
        8 39 "" --title "Modify User" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then continue; fi
        
        usermod -u ${uid} ${username}
        ;;
     #########################################
    esac
    ;;
##################################################
  "List Users")
    users=$(awk -F: '{print "UID "$3" : "$1} END {print "\nNumber of users: "NR}' /etc/passwd)
    whiptail --scrolltext --title "List Users" --msgbox \
    "${users}" 20 78
    continue
    ;;
##################################################
  "Add Group")
    groupname=$(whiptail --inputbox "Enter group name:" \
    8 39 "" --title "Add Group" 3>&1 1>&2 2>&3)
    if [ $? != 0 ]; then continue; fi
    groupadd ${groupname}
    ;;
##################################################
  "Modify Group")
    groupname=$(whiptail --inputbox "Enter group name:" \
    8 39 "" --title "Modify Group" 3>&1 1>&2 2>&3)
    if [ $? != 0 ]; then continue; fi
    opt=$(whiptail --title "Modify Group" --radiolist \
    "Choose an option" 20 78 4 \
    "GID" "The group ID of the given GROUP will be changed to GID." ON \
    "New Name" "The name of the group will be changed from GROUP to NEW_GROUP name." OFF \
    "Users" "A list of usernames to add as members of the group." OFF \
    3>&1 1>&2 2>&3)
    if [ $? != 0 ]; then continue; fi
    
    case $opt in
      "GID")
        gid=$(whiptail --inputbox "Enter new GID:" \
        8 39 "" --title "Modify Group" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then continue; fi
        groupmod -g ${gid} ${groupname}
        ;;
      ######################################
      "New Name")
        name=$(whiptail --inputbox "Enter new group name:" \
        8 39 "" --title "Modify Group" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then continue; fi
        groupmod -n ${name} ${groupname}
        ;;
      ######################################
      "Users")
        members=$(awk -F: -v GROUP="${groupname}" '{if ($1 == GROUP) print $4}' /etc/group)
        new_m=$(whiptail --inputbox "Enter group members:" \
        8 39 "${members}" --title "Modify Group" 3>&1 1>&2 2>&3)
        if [ $? != 0 ]; then continue; fi
        groupmod -U ${new_m} ${groupname}
        ;;
      ######################################
    esac
    ;;
##################################################
  "List Groups")
    groups=$(awk -F: '{print "GID "$3" : "$1} END {print "\nNumber of groups: "NR}' /etc/group)
    whiptail --scrolltext --title "List Groups" --msgbox \
    "${groups}" 20 78
    continue
    ;;
##################################################
  "Disable")
    username=$(whiptail --inputbox "Enter username:" \
    8 39 "" --title "Disable User" 3>&1 1>&2 2>&3)
    if [ $? != 0 ]; then continue; fi
    usermod -L -e 1 ${username}
    ;;
##################################################
  "Enable")
    username=$(whiptail --inputbox "Enter username:" \
    8 39 "" --title "Enable User" 3>&1 1>&2 2>&3)
    if [ $? != 0 ]; then continue; fi
    usermod -U -e -1 ${username}
    ;;
##################################################
  "Change Password")
    username=$(whiptail --inputbox "Enter username:" \
    8 39 "" --title "Change Password" 3>&1 1>&2 2>&3)
    if [ $? != 0 ]; then continue; fi
    while true; do
    pass1=$(whiptail --passwordbox "Enter your password" \
    8 78 --title "Change Password" 3>&1 1>&2 2>&3)
    if [ $? != 0 ]; then continue; fi
    if [ -z "$pass1" ]; then
      whiptail --title "Error" --msgbox "You entered empty password." 8 78
      continue
    fi
    
    pass2=$(whiptail --passwordbox "Confirm your password" \
    8 78 --title "Change Password" 3>&1 1>&2 2>&3)
    if [ $? != 0 ]; then continue; fi
    
    if [ "$pass1" == "$pass2" ]; then
      echo "$pass1" | passwd ${username} --stdin
      break
    else
      whiptail --title "Error" --msgbox "You entered unmatch passwords." 8 78
      continue
    fi
    done
    ;;
##################################################
  "About")
    about="
    This is a Bash script project for ITI intensive camp course.
    Created By Me.
    "
    whiptail --scrolltext --title "About" --msgbox \
    "${about}" 20 78
    ;;
esac
done








