echo "Installing Vim Plug for Neovim" 
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo "Done"

echo "Copying neo-vim config"
mkdir ~/.config/nvim
cp ./nvim/init.vim ~/.config/nvim/init.vim
cp ./nvim/coc-settings.json ~/.config/nvim/coc-settings.json
echo "Done"

echo "Installing Python dependencies"
pip3 install --user jedi pynvim
echo "Done"

nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall
