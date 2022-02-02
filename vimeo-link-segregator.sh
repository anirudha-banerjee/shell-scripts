#!/bin/bash
#Scripted by sissuphus69

#Colors for Banner
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

printf "${GREEN}"
cat << "EOF"

****************************************************************************************************************************************************
	_           _         _           _      _        _          _          _       _    _                  _             _        _          
       / /\        /\ \      / /\        / /\   /\ \     /\_\       /\ \       / /\    / /\ /\_\               / /\         /\ \     / /\         
      / /  \       \ \ \    / /  \      / /  \  \ \ \   / / /      /  \ \     / / /   / / // / /         _    / /  \       /  \ \   / /  \        
     / / /\ \__    /\ \_\  / / /\ \__  / / /\ \__\ \ \_/ / /      / /\ \ \   / /_/   / / / \ \ \__      /\_\ / / /\ \__   / /\ \_\ / / /\ \       
    / / /\ \___\  / /\/_/ / / /\ \___\/ / /\ \___\\ \___/ /      / / /\ \_\ / /\ \__/ / /   \ \___\    / / // / /\ \___\ / / /\/_//_/ /\ \ \      
    \ \ \ \/___/ / / /    \ \ \ \/___/\ \ \ \/___/ \ \ \_/      / / /_/ / // /\ \___\/ /     \__  /   / / / \ \ \ \/___// /_/_    \ \ \_\ \ \     
     \ \ \      / / /      \ \ \       \ \ \        \ \ \      / / /__\/ // / /\/___/ /      / / /   / / /   \ \ \     / /___/\    \ \/__\ \ \    
 _    \ \ \    / / /   _    \ \ \  _    \ \ \        \ \ \    / / /_____// / /   / / /      / / /   / / /_    \ \ \   / /\__ \ \    \_____\ \ \   
/_/\__/ / /___/ / /__ /_/\__/ / / /_/\__/ / /         \ \ \  / / /      / / /   / / /      / / /___/ / //_/\__/ / /  / / /__\ \ \          \ \ \  
\ \/___/ //\__\/_/___\\ \/___/ /  \ \/___/ /           \ \_\/ / /      / / /   / / /      / / /____\/ / \ \/___/ /  / / /____\ \ \          \ \ \ 
 \_____\/ \/_________/ \_____\/    \_____\/             \/_/\/_/       \/_/    \/_/       \/_________/   \_____\/   \/__________\/           \_\/ 


*****************************************************************************************************************************************************

!!!!! Vimeo Link Identifier, Verifier & Segregator !!!!!


EOF
printf "${NORMAL}"

#Script Starts

#Constants
START_SCRIPT="Start-Tool"
START_DUPLICATE_CHECKER="Start-Duplicate-Checker"
SCRIPT_QUIT="Quit"
SCRIPT_DELETE_LOG="Delete-Log"
SCRIPT_VERIFY="Start-Verifier"
SCRIPT_AGREGATE="Start-Agragate"

#Variables
arg_csv_path=""
arg_user_mobile=""
arg_user_name=""
arg_csv_output=""

#Functions
start_script() {
    rm -rf -v logs/*
	printf "Logs files cleaned\n"
    printf "Starting Script...\n\n"
	/usr/bin/python3 vimeo-link-identifier.py Video-Data-120122.csv
}

start_segragation_script() {
    rm -rf -v logs/*
	printf "Logs files cleaned\n"
    printf "Starting Script...\n\n"
	/usr/bin/python3 vimeo-link-checker.py vimeo-leftover-final.csv
}

start_link_verifier() {
    rm -rf -v logs/*
	printf "Logs files cleaned\n"
    printf "Starting Script...\n\n"
	/usr/bin/python3 vimeo-link-verifier.py vimeo-leftover.csv
}

start_link_agregator() {
    printf "Starting Script...\n\n"
    /usr/bin/python3 vimeo-link-aggregator.py
}

help() {
    # Display Help
    echo "Script that takes csv files as input and refines them into smaller categories as output"
    echo
    echo "Syntax: ./ws-whatsapp-category-util [-i|g|h|v]"
    echo "options:"
    echo "i     Print the instructions to use the script"
    echo "g     Print the GPL license notification."
    echo "h     Print this Help."
    echo "v     Print software version and exit."
    echo
}


#Main Program
PS3='Please enter your choice: '
menu_options=($START_SCRIPT $SCRIPT_DELETE_LOG $START_DUPLICATE_CHECKER $SCRIPT_VERIFY $SCRIPT_AGREGATE $SCRIPT_QUIT)
select opt in "${menu_options[@]}"
do
    case $opt in
        $START_SCRIPT)
            start_script
			break            
            ;;
		$SCRIPT_DELETE_LOG)
			rm -rf -v logs/*
			printf "Ouput directory cleaned\n"
			;;
        $START_DUPLICATE_CHECKER)
            start_segragation_script
			break
            ;;
        $SCRIPT_VERIFY)
            start_link_verifier
            break
            ;;
        $SCRIPT_AGREGATE)
            start_link_agregator
            break
            ;;
        $SCRIPT_QUIT)
            printf "Stopping the tool"
            break
            ;;
        *) printf "Invalid option. Try again"
			;;
    esac
done

exit 0

#Script Ends