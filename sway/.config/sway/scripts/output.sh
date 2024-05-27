#!/bin/bash

show_menu() {
	clear
	echo "Select an option:"
	echo "1. Main monitor"
	echo "2. Vertical samsung and main"
	echo "3. Acer"
	echo "4. Quit"
}

while true; do
	show_menu

	# Prompt the user to choose an option
	read -p "Enter the number of your choice: " choice

	# Process the choice
	case $choice in
	1)
		echo "You selected Option 1"
		sway output DP-1 res 1920x1080 pos 0 0
		sway output HDMI-A-1 disable
		# Add your actions for Option 1 here
		;;
	2)
		echo "You selected Option 2"
		sway output DP-1 res 1920x1080 pos 0 118
		sway output HDMI-A-1 enable res 1920x1080 pos 1920 0 transform 90
		# Add your actions for Option 2 here
		;;
	3)
		echo "You selected Option 3"
		sway output DP-1 res 1920x1080 pos 0 0
		sway output HDMI-A-1 enable res 1920x1080 pos 0 1080 transform 0
		# Add your actions for Option 3 here
		;;
	4)
		echo "Goodbye!"
		exit
		;;
	*)
		echo "Invalid choice. Please enter a valid option."
		;;
	esac

	# Wait for the user to press Enter before clearing the screen
	read -p "Press Enter to continue..."
done

# exec alacritty -e choose_from_menu
