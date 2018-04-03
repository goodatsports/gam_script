#!/usr/bin/bash
USERPROMPT="Enter username: "
# Parse Gmail domain from json file
DOMAIN="$(jq -r '.domain' env.json)"
while :
do
    cat<<EOF
    ---------------
    (1) List users
    (2) Add new user
    (3) Get user's group membership info 
    (4) Add user to group
    (5) Remove user from all groups
    (6) Suspend user
    (7) Quit
    ---------------
EOF
    read -p "> " -n1
    echo ""
    case "$REPLY" in
    "1") gam print users ;;
    "2") read -p "$USERPROMPT" USR
         read -p "Enter first name: " FIRSTNAME
         read -p "Enter last name: " LASTNAME
         read -sp "Enter new password: " PASS
         printf "\n"
         gam create user "$USR" firstname "$FIRSTNAME" lastname "$LASTNAME" password "$PASS" 
         printf "User $USR successfully created\n" ;;
    "3") read -p "$USERPROMPT" USR
         gam print groups member "$USR@$DOMAIN" && printf "\n" ;;
    "4") read -p "$USERPROMPT" USR
         read -p "Enter group name: " GROUP
         gam update group $GROUP add member "$USR@$DOMAIN" && printf "\n" ;;
    "5") read -p "$USERPROMPT" USR
         read -p "*** WARNING *** This will remove user $USR from ALL $DOMAIN Gmail groups. 
            Are you sure you want to do this? (type 'yes' to confirm): " CONFIRM
         case "$CONFIRM" in
         "yes"| "YES") gam user "$USR@$DOMAIN" delete groups;;
         esac                    ;;
    "6") read -p "$USERPROMPT" USR
         read -p "*** WARNING *** This will make $USR@$DOMAIN unable to login to their account.
         Are you sure you want to do this? (type 'yes' to confirm): " CONFIRM
         if [ "$CONFIRM" == "yes" ]; 
            then 
                gam update user "$USR@$DOMAIN" suspended on  
            fi ;;
    "7") exit                    ;;
     * )  echo "Invalid option"  ;;
    esac
done 
