# Enable VI-Mode
set -o vi

# Enable shell options
shopt -s histappend

# Setup prompts
blk='\[\033[01;30m\]'   # Black
red='\[\033[01;31m\]'   # Red
grn='\[\033[01;32m\]'   # Green
ylw='\[\033[01;33m\]'   # Yellow
blu='\[\033[01;34m\]'   # Blue
pur='\[\033[01;35m\]'   # Purple
cyn='\[\033[01;36m\]'   # Cyan
wht='\[\033[01;37m\]'   # White
clr='\[\033[00m\]'      # Reset

ps1_date_blk() {
	echo ${red}'['${cyn}'\D{%Y-%m-%d %H-%M-%S %a}'${red}']'${clr}
}

ps1_bash_ver_blk() {
	echo ${red}'['${cyn}'Bash \v'${red}']'${clr}
}

ps1_user_host_pwd_blk() {
	echo ${red}'<'${grn}'\u'${red}'@'${grn}'\H'${clr}':'${ylw}'\w'${red}'>'${clr}
}

PS1=$(ps1_date_blk)$(ps1_bash_ver_blk)'\n'$(ps1_user_host_pwd_blk)${cyn}'\n\$ '${clr}

# Setup bash history
HISTFILE=~/.bash_history
HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL="ingoredups:ingorespace"

# Aliases
alias vi="nvim"
alias vim="nvim"
alias sway="sway --unsupported-gpu"
alias nmtui="unset COLORTERM; TERM=xterm-old nmtui; export COLORTERM=truecolor"

# Some Rider shit
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi
