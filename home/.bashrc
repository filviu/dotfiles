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

# set default editor
export EDITOR=vim
export VISUAL=vim

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
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


if [ -f ~/.LESS_TERMCAP ]; then
	test -r ~/.LESS_TERMCAP && . ~/.LESS_TERMCAP
fi

if [ -f ~/.bash_aliases ]; then
    test -r ~/.bash_aliases && . ~/.bash_aliases
fi

# permit untracked bash completions
if [ -f ~/.bash_completion.local ]; then
	test -r ~/.bash_completion.local && . ~/.bash_completion.local
fi

PATH=$PATH:~/bin
export MC_SKIN="$HOME/.config/mc/solarized.ini"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

homeshick --quiet refresh

