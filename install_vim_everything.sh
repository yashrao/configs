if ! [ -x "$(command -v nvim)" ]; then # Checking if neovim is installed
  # If not question the user if they want to install the neovim configs anyway
  echo 'Error: neovim not installed, install neovim configs? (Y/n)' >&2
  read input
  if [[ $input == "Y" || $input == "y" ]]; then
    echo "Creating Neovim Config"
    mkdir ~/.config/nvim
    echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after" >> ~/.config/nvim/init.vim
    echo "let &packpath=&runtimepath" >> ~/.config/nvim/init.vim
    echo "source ~/.vimrc" >> ~/.config/nvim/init.vim
    echo "Please install Neovim after the script is finished!"
  else
    echo "Creating Neovim Config... Skipping!"
  fi
else
  # If neovim is installed then just make the init.vim file no questions
  echo "Creating Neovim Config"
  mkdir ~/.config/nvim
  echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after" >> ~/.config/nvim/init.vim
  echo "let &packpath=&runtimepath" >> ~/.config/nvim/init.vim
  echo "source ~/.vimrc" >> ~/.config/nvim/init.vim
fi

echo "Getting vim theme"
wget https://raw.githubusercontent.com/cocopon/iceberg.vim/master/colors/iceberg.vim -P ~/.vim/colors
echo "Done"

echo "Copying vimrc"
cp ./vim/vimrc ~/.vimrc
echo "Done"

echo "Installing NerdTree"
git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q
echo "Done"
