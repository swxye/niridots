#!/bin/sh

cd ~/Wallpapers

WALLPAPER=$(find "$PWD" -type f | shuf -n 1)
hellwal -i $WALLPAPER --check-contrast
swaync-client -rs
swww img --resize crop --transition-type none --transition-step 255 $WALLPAPER

function angle-randomizer {
	num=$(( ( $RANDOM % 61 ) - 30 ))
	bi_selector=$(( $RANDOM % 2 ))

	if (( $bi_selector == 0 )); then
		if (( $num < 0 )); then
			echo $(( ( $num - $num - $num ) + 330 ))
		else
			echo $num
		fi
	fi

	if (( $bi_selector == 1 )); then
		echo $(( $num + 150 ))
	fi
}

function transition-randomizer {
	bi_selector=$(( $RANDOM % 2 ))
	if (( $bi_selector == 0 )); then
		echo "wipe"
	fi

	if (( $bi_selector == 1 )); then
		echo "any"
	fi
}

while true; do
	sleep 300

	WALLPAPER=$(find "$PWD" -type f | shuf -n 1)
    hellwal -i $WALLPAPER --check-contrast
    swaync-client -rs
	swww img --resize crop --transition-type $( transition-randomizer ) --transition-step 255 --transition-fps 60 --transition-duration 1 --transition-angle $( angle-randomizer ) $WALLPAPER
done
