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

```sh
homeshick clone silviuvulcan/dotfiles
homeshick clone gmarik/Vundle
homeshick -v link
```

Post-Install steps:

```sh
vim "+:BundleInstall"
```

