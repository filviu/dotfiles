my dotfiles repo to use with homeshick; feel free to browse around, take anything you like :)

# Installation Steps

```bash
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
homeshick clone gmarik/Vundle
homeshick clone silviuvulcan/dotfiles
vim +:BundleInstall +qall
```

Optional steps:

```sh
homeshick clone private.server.com/privatedots
```

