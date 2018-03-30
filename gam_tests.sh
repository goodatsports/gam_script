#!/usr/bin/bash
USERPROMPT="Enter username: "
while :
do
    cat<<EOF
    ---------------
    (1) Add new user
    (2) Get user info
    (3) Add user to group
    (4) Quit
    ---------------
EOF

    read -n1 -s
    case "$REPLY" in
    "1") read -p "$USERPROMPT" USR
         read -p "Enter first name: " FIRSTNAME
         read -p "Enter last name: " LASTNAME
         read -sp "Enter new password: " PASS
         printf "\n"
         gam create user "$USR" firstname "$FIRSTNAME" lastname "$LASTNAME" password "$PASS" 
         echo "User $USR successfully created" ;;
    
    "2") read -p "$USERPROMPT" USR
         gam info user "$USR"
         exit                   ;;
    "3") echo "$USERPROMPT"     ;;
    "4") exit                   ;;
     * ) echo "Invalid option"  ;;
    esac
done 
