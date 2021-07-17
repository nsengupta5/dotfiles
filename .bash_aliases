# Misc Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias batt='upower -i /org/freedesktop/UPower/devices/battery_BAT1 | awk -F ":" '\''/percentage|state|time/ {print  }'\'
alias cat='bat --theme=OneHalfDark'
alias cclips=': > ~/clipper_history'
alias grep='rg --line-number --color=auto'
alias hg='kitty +kitten hyperlinked_grep'
alias homepass='sudo cat /etc/NetworkManager/system-connections/Sengupta_5GHz | grep psk='
alias icat='kitty +kitten icat'
alias la='ls -lah'
alias lclips='cat ~/clipper_history'
alias ls='exa -al --color=always --group-directories-first'
alias md='mkdir -p'
alias nvim='~/Downloads/nvim.appimage'
alias open='xdg-open'
alias pip='pip3'
alias python='python3'
alias sqlite='sqlite3'
alias tldr='tldr -t '\''base16'\'
alias tx='tmuxinator start'
alias uptime='uptime --pretty'
alias vpn='protonvpn-cli'
alias yt='mpsyt'
alias ytclear='rm ~/.config/mps-youtube/cache_py_*'
alias ispt="spotifyd --zeroconf-port 4444"
alias getp='sudo apt-get install'

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
alias gpsh='git push origin'
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
	SONG=$(ssong | awk -F " -" '{print $1}' | sed 's/[^a-zA-Z0-9]*//g' | awk '{print tolower($0)}') 
	ARTIST=$(ssong | awk -F "- " '{print $NF}') 
	if [[ "$ARTIST" == *,* ]]
	then
		ARTIST=$(echo "$ARTIST" | awk -F "," '{print $1}') 
	fi
	ARTIST=$(echo "$ARTIST" | sed 's/[^a-zA-Z0-9]*//g' | awk '{print tolower($0)}') 
	if [[ "$ARTIST" == the* ]]
	then
		ARTIST=$(sed 's/the//' "$ARTIST") 
	fi

	wget --output-document lyrics.txt --user-agent "Mozilla" -q https://www.azlyrics.com/lyrics/"$ARTIST"/"$SONG".html
	if [ $? -ne 0 ]
	then
		echo "ERROR: Lyrics not found"
	else
		\grep "<br>" lyrics.txt | sed -e "s/<[^>]*>//g"
		rm lyrics.txt
	fi
}

# Plays a youtube video based on a DuckDuckGo search
ptube () {
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
}

# Creates a directory and moves into it
mkcd () {
	DIRECTORY="$1" 
	if [ -d "$DIRECTORY" ]
	then
		echo "Directory already exists"
	else
		mkdir "$DIRECTORY"
		cd "$DIRECTORY" || return
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
	TITLE="$(chain " " "$@")"
	spt play --name "$TITLE" --track
}

# Plays a playlist
plist () {
	TITLE="$(chain " " "$@")"
	spt play --name "$TITLE" --playlist
}

# Plays the next nth song in the playlist
pnext () {
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
}

# Plays the previous nth song in the playlist
pprev () {
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
}

# Lists playlists 
llists () {
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
}

# List liked songs
lliked () {
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
}

# Finds songs
fsong () {
	TITLE="$(chain " " "$@")"
	spt search "$TITLE" --tracks
}

# Adds a song to the queue
qsong () {
	TITLE="$(chain " " "$@")"
	spt play --name "$TITLE" --track --queue
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
	if [ $# -eq 0 ]
	then
		w3m www.duckduckgo.com
	else
		QUERY="$(chain "+" "$@")"
		w3m "https://duckduckgo.com/?q=$QUERY"
	fi
}

# Executes a Brave search
brave() {
	if [ $# -eq 0 ]
	then
		w3m search.brave.com
	else
		QUERY="$(chain "+" "$@")"
		w3m "https://search.brave.com/search?q=$QUERY"
	fi
}

# Executes a Google search
google () {
	if [ $# -eq 0 ]
	then
		w3m www.google.com
	else
		QUERY="$(chain "+" "$@")" 
		w3m "https://www.google.com/search?q=$QUERY"
	fi
}
