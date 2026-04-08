# Enable VI-Mode
set -o vi

# Enable shell options
shopt -s histappend

# Setup prompts
blk='\[\033[01;30m\]'	# Black
red='\[\033[01;31m\]'	# Red
grn='\[\033[01;32m\]'	# Green
ylw='\[\033[01;33m\]'	# Yellow
blu='\[\033[01;34m\]'	# Blue
pur='\[\033[01;35m\]'	# Purple
cyn='\[\033[01;36m\]'	# Cyan
wht='\[\033[01;37m\]'	# White
clr='\[\033[00m\]'		# Reset

# Some shit prompts
ps1_date_blk() {
	printf '%s[%s\D{%%Y-%%m-%%d %%H-%%M-%%S %%a}%s]%s' "$red" "$cyn" "$red" "$clr"
}

ps1_bash_ver_blk() {
	printf '%s[%sBash \\v%s]%s' "$red" "$cyn" "$red" "$clr"
}

ps1_user_host_pwd_blk() {
	printf '%s<%s\\u%s@%s\H%s:%s\w%s>%s' "$red" "$grn" "$red" "$grn" "$red" "$ylw" "$red" "$clr"
}

export PS1 PS2 PS4
PS1="$(ps1_date_blk)$(ps1_bash_ver_blk)\n$(ps1_user_host_pwd_blk)${cyn}\n\$ ${clr}"
PS2="${cyn}> ${clr}"
PS4="-> "


# Setup bash history
export HISTFILE=~/.bash_history
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL="ignorespace"

# Aliases
alias ls="ls --color"
alias vi="nvim"
alias vim="nvim"
alias sway="sway --unsupported-gpu"


# Cd into dir on vifm exit
nmtui() {
	(unset COLORTERM; TERM=xterm-old command nmtui)
}

vifm() {
  local dest
  dest="$(command vifm --choose-dir - "$@")"

  if [[ -z "$dest" ]]; then
	echo "Directory picking failed." >&2
	return 1
  fi

  cd "$dest" || return 1
}

bullshit() {
	if ! [[ "$1" -gt 0 ]]; then
		echo "Can't produce bullshit of length '$1'" >&2
		return 1
	fi

	tr -cd '[:graph:]' < /dev/urandom | head -c "$1"
	echo
}
