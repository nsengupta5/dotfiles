# Misc Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias batt='upower -i /org/freedesktop/UPower/devices/battery_BAT1 | awk -F ":" '\''/percentage|state|time/ {print  }'\'
alias cat='bat --theme=base16'
alias cclips=': > ~/clipper_history'
alias grep='rg --line-number --color=auto'
alias hg='kitty +kitten hyperlinked_grep'
alias homepass='sudo cat /etc/NetworkManager/system-connections/Sengupta_5GHz | grep psk='
alias icat='kitty +kitten icat'
alias la='ls -lah'
alias lclips='cat ~/clipper_history'
alias ls='exa -al --color=always --group-directories-first'
alias md='mkdir -p'
alias pip='pip3'
alias sqlite='sqlite3'
alias uptime='uptime --pretty'
alias vpn='protonvpn-cli'
alias yt='mpsyt'
alias ytclear='rm ~/.config/mps-youtube/cache_py_*'
alias ispt="spotifyd"
alias open="xdg-open"
alias termopen="~/Downloads/termpdf.py/termpdf.py"
alias wordle='ssh clidle.ddns.net -p 3000'
alias fd='fd --hidden --no-ignore'
alias tuir='tuir --enable-media'

# Temporary Aliases
alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.11.1-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java -Xmx500M -cp "/usr/local/lib/antlr-4.9-complete.jar.jar:$CLASSPATH" org.antlr.v4.gui.TestRig'

# Spotify Aliases
alias dlsong='spt playback --dislike'
alias tsong='spt playback --toggle'
alias tshuffle='spt playback --shuffle'
alias ssong='spt playback --status'
alias pliked='spt play --name liked --playlist'
alias lsong='spt playback --like'

# Git Aliases
alias ga='git add'
alias gb='git branch'
alias gc='git commit -m'
alias gs='git status'
alias gpull='git pull'
alias gr='git reset -HEAD'
alias gl='git log'
alias gchk='git checkout'

# SSH Aliases
alias sshget='touch clipper.txt; cat < clipper > clipper.txt; clip clipper.txt; rm clipper.txt'
alias sshstart='sudo service ssh start'
alias sshstop='sudo service ssh stop'

# Misc Functions

# Connects arguements with a custom chain string
chain() {
	if [[ $# -eq 0 ]] || [[ $# -eq 1 ]]
	then
		echo "Invalid number of arguments"
		return 1
	elif [[ $# -eq 2 ]]
	then
		local QUERY="$2"
		echo "$QUERY"
	else
		CHAIN="$1"
		local QUERY="" 
		for word in "${@:2}"
		do
			QUERY+="${word}$CHAIN" 
		done
		echo "${QUERY: : -1}"
	fi
}

# Prints the lyrics of the song currently playing
lyrics () {
	if command -v spt >/dev/null 2>&1 ;
	then
		if [[ $# -eq 0 ]]
		then
			FULL=$(ssong)
		else
			QUERY="$(chain "+" "$@")" 
			FULL=$(w3m -dump https://search.azlyrics.com/search.php\?q\="$QUERY" | \grep "1\." | cut -d ' ' -f2- | tr -d '"')
		fi

		SONG=$(echo "$FULL" | awk -F " -" '{print $1}' | sed 's/[^a-zA-Z0-9]*//g' | awk '{print tolower($0)}') 
		ARTIST=$(echo "$FULL" | awk -F "- " '{print $NF}') 
		if [[ "$ARTIST" == *,* ]]
		then
			ARTIST=$(echo "$ARTIST" | awk -F "," '{print $1}') 
		fi
		ARTIST=$(echo "$ARTIST" | sed 's/[^a-zA-Z0-9]*//g' | awk '{print tolower($0)}') 
		if [[ "$ARTIST" == the* ]]
		then
			ARTIST=$(echo "$ARTIST" | sed 's/the//') 
		fi

		wget --output-document lyrics.txt --user-agent "Mozilla" -q https://www.azlyrics.com/lyrics/"$ARTIST"/"$SONG".html
		if [ $? -ne 0 ]
		then
			echo "ERROR: Lyrics not found"
		else
			\grep "<br>" lyrics.txt | sed -e "s/<[^>]*>//g"
		fi
		rm lyrics.txt
	else
		echo "Spotify Tui not installed"
	fi
}

# Plays a youtube video based on a DuckDuckGo search
ptube () {
	if command -v mpv >/dev/null 2>&1 ;
	then
		if [ $# -eq 0 ]
		then
			echo "ERROR: No arguments provied"
		else
			QUERY="$(chain "+" "$@")"
			wget --output-document=tmp --user-agent "Mozilla" -q "https://lite.duckduckgo.com/lite/?q=$QUERY+youtube" 
			RESULTS=$(\grep "link-text'>www.youtube.com" tmp | awk -F ">" '{print $2}' | sed 's|</span||g') 
			rm tmp
			if [ "$RESULTS" ]
			then
				echo "$RESULTS" | nl
				read -r "?Enter a number: " NUM
				VID=$(echo "$RESULTS" | sed -n "$NUM p")
				mpv "https://$VID"
			else
				echo "ERROR: No videos found"
			fi
		fi
	else
		"mpv not installed"
	fi
}

# Sends command output to phone via KDE Connect
send_comm() {
	if command -v kdeconnect-cli > /dev/null 2>&1 ;
	then
		if [ $# -eq 0 ]
		then
			echo "ERROR: No arguments provided"
		else
			QUERY="$1"	
			kdeconnect-cli -d $(kdeconnect-cli -a --id-only) --ping-msg $("$QUERY")
		fi
	else
		"kdeconnect-cli not installed"
	fi
}

# Controls the screen brightness 
brightness () {
	LEVEL="$1" 
	if (( $(echo "$LEVEL <= 0.0" | bc -l ) ))
	then
		echo "Brightness cannot be below 0"
	elif (( $(echo "$LEVEL > 1.5" | bc -l ) ))
	then
		echo "Brightness too high"
	else
		xrandr --output eDP-1 --brightness "$LEVEL"
	fi
}

# Clips the argument to the system clipboard
clip () {
	FILE="$1" 
	if [ -f "$FILE" ]
	then
		xclip -selection clipboard < "$FILE"
		echo "$FILE contents copied"
	else
		echo "$FILE" | xclip -selection clipboard
		echo "$FILE" >> ~/clipper_history
	fi
}

# Spotify Functions

# Plays a song
psong () {
	if command -v spt >/dev/null 2>&1 ;
	then
		TITLE="$(chain " " "$@")"
		spt play --name "$TITLE" --track
	else
		echo "Spotify Tui not installed"
	fi
}

# Plays a playlist
plist () {
	if command -v spt >/dev/null 2>&1 ;
	then
		TITLE="$(chain " " "$@")"
		spt play --name "$TITLE" --playlist
	else
		echo "Spotify Tui not installed"
	fi
}

fseek () {
	if command -v spt >/dev/null 2>&1 ;
	then
		SECONDS="$1"
		spt pb --seek +"$SECONDS"
	else
		echo "Spotify Tui not installed"
	fi
}

bseek () {
	if command -v spt >/dev/null 2>&1 ;
	then
		SECONDS="$1"
		spt pb --seek -"$SECONDS"
	else
		echo "Spotify Tui not installed"
	fi
}

# Plays the next nth song in the playlist
pnext () {
	if command -v spt >/dev/null 2>&1 ;
	then
		if [ $# -eq 0 ]
		then
			spt playback --next
		else
			REQ="" 
			NUM="$1" 
			for i in {1..$NUM}
			do
				REQ+="n" 
			done
			spt pb -"$REQ"
		fi
	else
		echo "Spotify Tui not installed"
	fi
}

# Plays the previous nth song in the playlist
pprev () {
	if command -v spt >/dev/null 2>&1 ;
	then
		if [ $# -eq 0 ]
		then
			spt playback --previous
		else
			REQ="" 
			NUM="$1" 
			for i in {1..$NUM}
			do
				REQ+="p" 
			done
			spt pb -"$REQ"
		fi
	else
		echo "Spotify Tui not installed"
	fi
}

# Lists playlists 
llists () {
	if command -v spt >/dev/null 2>&1 ;
	then
		LIMIT=$1 
		if [ $# -eq 0 ]
		then
			spt list --playlists --limit 20 | awk -F "(" '{print $1}'
		elif [ "$LIMIT" -lt 50 ] || [ "$LIMIT" -gt 1 ]
		then
			spt list --playlists --limit "$LIMIT" | awk -F "(" '{print $1}'
		else
			echo "ERROR: Limit should be between 0 and 50"
		fi
	else
		echo "Spotify Tui not installed"
	fi
}

# List liked songs
lliked () {
	if command -v spt >/dev/null 2>&1 ;
	then
		LIMIT=$1 
		if [ $# -eq 0 ]
		then
			spt list --limit 20 --liked 
		elif [ "$LIMIT" -lt 50 ] || [ "$LIMIT" -gt 1 ]
		then
			spt list --limit "$LIMIT" --liked
		else
			echo "ERROR: Limit should be between 0 and 50"
		fi
	else
		echo "Spotify Tui not installed"
	fi
}

# Finds songs
fsong () {
	if command -v spt >/dev/null 2>&1 ;
	then
		TITLE="$(chain " " "$@")"
		spt search "$TITLE" --tracks
	else
		echo "Spotify Tui not installed"
	fi
}

# Adds a song to the queue
qsong () {
	if command -v spt >/dev/null 2>&1 ;
	then
		TITLE="$(chain " " "$@")"
		spt play --name "$TITLE" --track --queue
	else
		echo "Spotify Tui not installed"
	fi
}

# Git Functions

# Pushes all files to the master branch
gpa () {
	MESSAGE="$1" 
	git add -A
	git commit -m "$MESSAGE"
	git push origin master
}

# SSH Functions
sshsend () {
	CONTENTS="$1" 
	echo "$CONTENTS" > clipper
}

# w3m Functions

# Executes a DuckDuckGo search
ddgo () {
	if command -v w3m >/dev/null 2>&1 ;
	then
		if [ $# -eq 0 ]
		then
			w3m www.duckduckgo.com
		else
			QUERY="$(chain "+" "$@")"
			w3m "https://duckduckgo.com/?q=$QUERY"
		fi
	else
		echo "w3m not installed"
	fi
}

# Executes a Google search
google () {
	if command -v w3m >/dev/null 2>&1 ;
	then
		if [ $# -eq 0 ]
		then
			w3m www.google.com
		else
			QUERY="$(chain "+" "$@")" 
			w3m "https://www.google.com/search?q=$QUERY"
		fi
	else 
		echo "w3m not installed"
	fi
}

# Executes a ChatGPT search
gpt () {
	if [ $# -eq 0 ]
	then
		chatgpt
	else
		QUERY="$(chain " " "$@")" 
		echo $QUERY
		chatgpt "$QUERY" > tmp.md; glow tmp.md; rm tmp.md
	fi
}

pjava () {
	rm -rf /tmp/processing
	mkdir /tmp/processing
	/home/nsengupta5/Downloads/Processing/processing-4.1.2/processing-java --output=/tmp/processing/ --force --sketch=$1 --run
}
