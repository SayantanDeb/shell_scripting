#!/bin/bash]

#Ask for the user name.
read -p 'Enter the username you want to create: ' USER_NAME

#Ask for the real name.
read -p 'Enter the name of the person, who this account is for: ' NAME

#Ask for the password.
read -s -p 'Enter the password to use, for the account: ' PASSWORD

#Create the user.
useradd -c "${COMMENT}" -m ${USER_NAME}

#Set the password for the user.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

#Force password change on first login.
passwd -e ${USER_NAME}

#Display the username, password, and the host where the user was created.


