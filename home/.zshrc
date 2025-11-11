export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/curl/bin:$HOME/bin:$PATH"
export MC_SKIN="$HOME/.config/mc/jult.ini"

export HOMEBREW_NO_ENV_HINTS=1

# mc is slow on macOS otherwise
alias mc="SHELL=/bin/bash mc"
alias mcedit="SHELL=/bin/bash mc -e"

alias ll="ls -l --color=auto"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

# useful only for Mac OS Silicon M1, 
# still working but useless for the other platforms
# since I'm not developing anything for arm64 this makes sense all the time
docker() {
 if [[ `uname -m` == "arm64" ]] && [[ "$1" == "run" || "$1" == "build" ]]; then
    /opt/homebrew/bin/docker "$1" --platform linux/amd64 "${@:2}"
  else
     /opt/homebrew/bin/docker "$@"
  fi
}

# source antidote https://antidote.sh/
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  #eval "$(oh-my-posh init zsh --config ~/.filv.omp.yaml)"
  eval "$(starship init zsh)"
fi

# completion both for kubectl and k alias
if command -v kubectl &> /dev/null; then
    source <(kubectl completion zsh)
    alias compdef k="kubectl"
    alias k="kubectl"
    alias ksy="kubectl -n kube-system"
    alias kgp="kubectl get pods"
    alias kgs="kubectl get services"
fi

eval "$(atuin init zsh --disable-up-arrow)"
. <(atuin gen-completions --shell zsh)

if command -v helm &>/dev/null; then
    source <(helm completion zsh)
fi

if command -v docker &>/dev/null; then
    source <(docker completion zsh)
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
test -e "${HOME}/.zshrc.local" && source "${HOME}/.zshrc.local"

