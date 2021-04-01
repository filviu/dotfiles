# Installation Steps

```bash
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
homeshick clone gmarik/Vundle
homeshick clone chris-marsh/pureline
homeshick clone silviuvulcan/dotfiles
vim +:BundleInstall +qall
```

Optional steps:

```sh
homeshick clone private.server.com/privatedots
```

Dependencies:

```sh
git grc mc vim
```