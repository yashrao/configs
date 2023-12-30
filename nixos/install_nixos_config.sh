
## NOTE: THIS IS FOR HOME MANAGER 23.11
## FIND THE LATEST VERSION AND UPDATE ACCORDINGLY
## Refer to https://nix-community.github.io/home-manager/index.xhtml#sec-install-nixos-module
name=$(uname -a)
if [[ $name == *"nixos"* ]]; then
    echo \"Installing Home Manager 23.11 (Unstable)\"
    sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
    sudo nix-channel --update
    sudo cp configuration.nix /etc/nixos/
    sudo nixos-rebuild switch
fi

cd ..
cp emacs.d/emacs.d/init.el $HOME/.emacs.d/
sh install_kitty_config.sh
sh install_vim_everything.sh
cp tmux.conf $HOME/.tmux.conf
dconf write /org/gnome/desktop/peripherals/touchpad/natural-scroll false # for gnome

echo "Manual Steps:"
echo "\t1) Firefox/Brave Browser Extensions"
echo "\t2) Sign into Telegram/Discord"
