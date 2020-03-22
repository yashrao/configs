mkdir ~/.zsh

# Install Zsh autosuggestions
echo "Installing Zsh Autosuggestions"
bash ./zsh_configs/install_autosuggestions.sh
echo "Done"

# Install Zsh highlighting
echo "Installing Zsh Highlighting"
bash ./zsh_configs/install_highlighting.sh
echo "Done"

# Install Liquid Prompt
echo "Installing Liquidprompt"
bash ./zsh_configs/install_liquidprompt.sh
echo "Done"

echo "Copying zshrc"
cp zsh_configs/zshrc ~/.zshrc
echo "Done"
