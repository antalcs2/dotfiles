# dotfiles

## Installing kitty
https://sw.kovidgoyal.net/kitty/

`sudo dnf install kitty`

## Installing neovim
https://github.com/neovim/neovim

```sh
cd ~/Downloads/Installers/
git clone https://github.com/neovim/neovim
cd neovim/
make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=$HOME/neovim/
sudo make install
```

## Applying config files
```sh
git clone https://github.com/antalcs02/dotfiles.git ~/.dotfiles
cd .dotfiles
stow .
```

Use the `Wallpaper Slideshow` GNOME extension and set the `backgrounds` folder as it's Slideshow Directory. The `backgrounds` directory is ignores by stow.
