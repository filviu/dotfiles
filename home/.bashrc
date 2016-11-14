# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=500000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

#LANGUAGE ERRORS
#export LANGUAGE=en_US.UTF-8
#export LANG=en_US.UTF-8
#export LC_ALL=en_US.UTF-8

# set default editor
export EDITOR=vim
export VISUAL=vim

# remove mint/ubuntu command not found message
unset command_not_found_handle

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm) color_prompt=yes;;
	xterm-color) color_prompt=yes;;
	xterm-256color) color_prompt=yes;;
	putty-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
	export PS1="[\[\e[00;34m\]\u\[\e[0m\]\[\e[00;37m\]@\[\e[0m\]\[\e[00;36m\]\h\[\e[0m\] \[\e[00;33m\]\w\[\e[0m\]]\[\e[00;37m\]\\$\[\e[0m\] "
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;$\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	if [ -z "$LS_COLORS" ]; then
		test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	fi
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# GRC colorizes nifty unix tools all over the place
if $(grc &>/dev/null)
then
  GRC=`which grc`
  if [ "$TERM" != dumb ] && [ -n GRC ]
  then
    alias colourify="$GRC -es --colour=auto"
    alias configure='colourify ./configure'
    alias diff='colourify diff'
    alias make='colourify make'
    alias gcc='colourify gcc'
    alias g++='colourify g++'
    alias ld='colourify ld'
    alias netstat='colourify netstat'
    alias ping='colourify ping'
    alias traceroute='colourify /usr/sbin/traceroute'
  fi
fi

if [ -f ~/.LESS_TERMCAP ]; then
	test -r ~/.LESS_TERMCAP && . ~/.LESS_TERMCAP
fi

if [ -f ~/.bash_aliases ]; then
    test -r ~/.bash_aliases && . ~/.bash_aliases
fi

# custom aliases, settings
if [ -f ~/.bash_completion.local ]; then
	test -r ~/.bash_completion.local && . ~/.bash_completion.local
fi

if [ -f ~/.bashrc.local ]; then
	test -r ~/.bashrc.local && . ~/.bashrc.local
fi

PATH=$PATH:~/bin
export MC_SKIN="$HOME/.config/mc/solarized.ini"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"


