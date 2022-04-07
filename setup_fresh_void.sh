### Script to setup Fresh Void Linux install

sudo sh -c "cat blacklist pcspkr >> /etc/modprobe.d/nobeep.conf"

sudo xbps-install -Sy vpm python3-pip curl wget neofetch neovim cargo lightdm lightdm-gtk3-greeter unzip zsh git
wget "https://github.com/catppuccin/gtk/releases/download/update_23_02_2022/Catppuccin-pink.zip"
unzip Catpuccin-pink.zip
sudo mv Catppuccin-pink /usr/share/themes/
wget -qO- https://git.io/papirus-icon-theme-install | sh
git clone https://github.com/catppuccin/papirus-folders.git
cd papirus-folders
sudo cp -r src/* /usr/share/icons/Papirus
./papirus-folders -C cat-pink --theme Papirus-Dark
cd ..

cargo install lsd
cat "export PATH=\$PATH:$HOME/.cargo/bin/"

mkdir /$HOME/.fonts/
wget "https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf"
mv Hack* /$HOME/.fonts/
fc-cache

bash install_neovim_everything.sh
bash install_zsh_everything.sh
