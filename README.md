# Installation Steps

```bash
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
homeshick clone gmarik/Vundle
homeshick clone filviu/dotfiles
vim +:BundleInstall +qall
cp -L ~/.config/mc/ini.orig ~/.config/mc/ini
```

Optional steps:

```sh
homeshick clone private.server.com/privatedots
```

Dependencies:

```sh
git grc mc vim
```

ble.sh - https://github.com/akinomyoga/ble.sh

```bash
curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf -
mv ble-nightly ~/.local/share/blesh
```

starship - https://starship.rs/

```bash
curl -sS https://starship.rs/install.sh | sh
```

optional atuin - https://atuin.sh/
