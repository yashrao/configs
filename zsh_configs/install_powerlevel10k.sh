echo "Installing Powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
echo "## Powerlevel10k" >> ~/.zsh/custom.zsh
echo 'source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zsh/custom.zsh
echo "Done"
