export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/curl/bin:$HOME/bin:$HOME/.local/bin:$PATH"
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
  local bin
  # whence -p resolves the real external binary, skipping this function.
  # (command -v docker would return the function name and recurse infinitely.)
  bin=$(whence -p docker 2>/dev/null) || { echo "docker: command not found" >&2; return 127; }

  if [[ `uname -m` == "arm64" ]] && [[ "$1" == "run" || "$1" == "build" ]]; then
    "$bin" "$1" --platform linux/amd64 "${@:2}"
  else
     "$bin" "$@"
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
if whence -p kubectl &> /dev/null; then
    source <(kubectl completion zsh)
    alias compdef k="kubectl"
    alias k="kubectl"
    alias ksy="kubectl -n kube-system"
    alias kgp="kubectl get pods"
    alias kgs="kubectl get services"
fi

eval "$(atuin init zsh --disable-up-arrow)"
. <(atuin gen-completions --shell zsh)

if whence -p helm &>/dev/null; then
    source <(helm completion zsh)
fi

if whence -p docker &>/dev/null; then
    source <(docker completion zsh)
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
test -e "${HOME}/.zshrc.local" && source "${HOME}/.zshrc.local"
