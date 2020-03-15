echo "Installing Liquidprompt"


echo "## LiquidPrompt" >> ~/.zsh/custom.zsh
cd
git clone https://github.com/nojhan/liquidprompt.git ~/.zsh/liquidprompt
echo "source ~/.zsh/liquidprompt/liquidprompt" >> ~/.zsh/custom.zsh
source ~/.zsh/custom.zsh

echo "Done"
