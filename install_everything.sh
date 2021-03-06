echo "Copying Zsh Config"
# Copy zshrc over
cp ./zsh_configs/zshrc ~/.zshrc

echo "Installing Zsh items"
bash install_zsh_everything.sh

echo "Installing Vim items"
bash install_vim_everything.sh

echo "Copying Kitty Config"
bash install_kitty_config.sh
