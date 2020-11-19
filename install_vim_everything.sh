if ! [ -x "$(command -v nvim)" ]; then # Checking if neovim is installed
  # If not question the user if they want to install the neovim configs anyway
  echo 'Error: neovim not installed, install neovim configs? (Y/n)' >&2
  read input
  if [[ $input == "Y" || $input == "y" ]]; then
    echo "Creating Neovim Config"
    mkdir ~/.config/nvim
    cp nvim/init.vim ~/.config/nvim/init.vim
    echo "Please install Neovim after the script is finished!"
    echo "Don't forget to run PlugInstall in neovim"
  else
    echo "Creating Neovim Config... Skipping!"
  fi
else
  # If neovim is installed then just make the init.vim file no questions
  echo "Creating Neovim Config"
  mkdir ~/.config/nvim
  cp nvim/init.vim ~/.config/nvim/init.vim
  echo "Don't forget to run PlugInstall in neovim"
fi

echo "Getting vim themes"
echo "Iceberg"
wget https://raw.githubusercontent.com/cocopon/iceberg.vim/master/colors/iceberg.vim -P ~/.vim/colors
echo "Done"
wget https://raw.githubusercontent.com/challenger-deep-theme/vim/master/colors/challenger_deep.vim -P ~/.vim/colors
echo "Done"

echo "Copying vimrc"
cp ./vim/vimrc ~/.vimrc
echo "Done"

echo "Installing NerdTree"
git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q
echo "Done"
