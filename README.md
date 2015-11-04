dotfiles
========

my dotfiles repo to use with homeshick; feel free to browse around, take anything you like :)

Installation:

```sh
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
```

```sh
printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.bashrc
```
This adds a line to your `.bashrc` which includes a script that defines the `homeshick()` function.

To get tab completion working in bash, simply source
`completions/homeshick-completion.bash` somewhere in your `.bashrc`.

```sh
printf '\nsource "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"' >> $HOME/.bashrc
```

Since my dotfiles .bashrc already has those, it's enough to source manually on first deploy...

STEPS
=====

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

