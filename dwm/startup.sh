autorandr --change
#sleep 1
nitrogen --restore
picom -b

export SEP1=" | "
export SEP2=""

dwm_date () {
    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "📆 %s" "$(date "+%a %d-%m-%y %T")"
    else
        printf "  %s" "$(date "+%a %d-%m-%y %T")"
    fi
    printf "%s\n" "$SEP2"
}

dwm_alsa () {
	STATUS=$(amixer sget Master | tail -n1 | sed -r "s/.*\[(.*)\]/\1/")
    VOL=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
    #printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
    	if [ "$STATUS" = "off" ]; then
	           printf "🔇"
    	else
    		#removed this line becuase it may get confusing
	       if [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
	           printf "🔈 %s%%" "$VOL"
	       elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
	           printf "🔉 %s%%" "$VOL"
	       else
	           printf "🔊 %s%%" "$VOL"
	       fi
		fi
    else
    	if [ "$STATUS" = "off" ]; then
    		printf "婢"
    	else
	       # removed this line because it may get confusing
	       if [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
	           printf "奄 %s%%" "$VOL"
	       elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
	           printf "奔 %s%%" "$VOL"
	       else
	           printf "墳 %s%%" "$VOL"
        	fi
        fi
    fi
    printf "%s\n" "$SEP2"
}

while true
do

   # Append results of each func one by one to a string
    dispstr=""
    dispstr="$dispstr$(dwm_alsa)"
    dispstr="$dispstr$(dwm_date)"

    xsetroot -name "$dispstr"
    sleep 1

done
