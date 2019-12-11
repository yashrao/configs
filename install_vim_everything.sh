echo "Copying vimrc"
cp ./vim/vimrc ~/.vimrc

echo "Installing Pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
echo "Done"

echo "Installing NerdTree"
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
echo "Done"

echo "Installing airline"
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
echo "Done"
