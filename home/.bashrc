# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s histreedit
shopt -s histverify
shopt -s cmdhist

# don't put duplicate lines or lines starting with space in the history.
HISTTIMEFORMAT="%d/%m/%y %T "
HISTSIZE=100000
HISTFILESIZE=500000
HISTFILE="$HOME/.bash_history"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ "$TERM_PROGRAM" == "vscode" ]; then
    export EDITOR="code --wait"
    export VISUAL="code --wait"
    source /etc/bash_completion 2>/dev/null
    source /etc/profile.d/bash_completion.sh 2>/dev/null
else
    export EDITOR=vim
    export VISUAL=vim
fi

export MC_SKIN="$HOME/.config/mc/jult.ini"
export PATH=$PATH:~/bin:~/.local/bin/:~/.cargo/bin/

# remove mint/ubuntu command not found message
unset command_not_found_handle

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm) color_prompt=yes;;
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    putty-256color) color_prompt=yes;;
    cygwin) color_prompt=yes;;
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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# GRC colorizes nifty unix tools all over the place
if command -v grc &> /dev/null; then
  GRC=`which grc`
  if [ "$TERM" != dumb ] && [ -n GRC ]; then
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

[[ -f ~/.local/share/blesh/ble.sh ]] && source ~/.local/share/blesh/ble.sh

# bookmarks - inspired from
# https://threkk.medium.com/how-to-use-bookmarks-in-bash-zsh-6b8074e40774
# https://twitter.com/mattn_jp/status/1434192554036137995

if [ -d "$HOME/.bookmarks" ]; then
    export CDPATH=".:$HOME/.bookmarks:/"
    alias {g,go,goto}="cd -P"
    _goto()
    {
        local IFS=$'\n'
        COMPREPLY=( $( compgen -W "$(/bin/ls ~/.bookmarks)" -- ${COMP_WORDS[COMP_CWORD]}))
    } && complete -F _goto goto go g
fi

# pg-up/down autocompletion
# https://superuser.com/questions/171999/smart-tab-completion-for-directories
bind '"\e[6~": menu-complete'
bind '"\e[5~": menu-complete-backward'

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

if command -v hcloud &> /dev/null; then
    source <(hcloud completion bash)
fi

if command -v kubectl &> /dev/null; then
    source <(kubectl completion bash)
    complete -F __start_kubectl k
    alias k="kubectl"
    alias ksy="kubectl -n kube-system"
    alias kgp="kubectl get pods"
    alias kgs="kubectl get services"
fi

if command -v minikube &>/dev/null; then
  eval "$(minikube completion bash)"
fi

if command -v aws_completer &>/dev/null; then
    complete -C 'aws_completer' aws
fi

if command -v eksctl &>/dev/null; then
    . <(eksctl completion bash)
fi

if command -v helm &>/dev/null; then
    source <(helm completion bash)
fi

if command -v terraform &>/dev/null; then
    complete -C /usr/bin/terraform terraform
fi

source ~/.LESS_TERMCAP 2>/dev/null || true
source ~/.bash_aliases 2>/dev/null || true

# custom aliases, settings
source ~/.bash_completion.local 2>/dev/null || true
source ~/.bashrc.local 2>/dev/null || true
source ~/.bashrc.todo 2>/dev/null || true

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

source "$HOME/.cargo/env" 2>/dev/null || true

if command -v "$HOME/.atuin/bin/atuin" &>/dev/null; then
    . "$HOME/.atuin/bin/env"
    eval "$(atuin init bash --disable-up-arrow)"
    . <(atuin gen-completions --shell bash)
fi

if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
fi
