echo "Copying Zsh Config"
# Copy zshrc over
cp ./zsh_configs/zshrc ~/.zshrc

echo "Installing Zsh items"
bash install_zsh_everything.sh

echo "Installing Vim items"
bash install_vim_everything.sh

#echo "Copying Emacs Config"
# Emacs config
#cp ./emacs/emacs ~/.emacs

#echo "Copying Emacs Addons"
# Emacs Plugins
#cp -r ./emacs/emacs.d/ ~/.emacs.d

echo "Installing Doom Emacs"
bash install_doom_emacs.sh
