
echo "Copying Vim items"
sh install_vim_everything.sh

echo "Copying Kitty Config"
sh install_kitty_config.sh

echo "Copying tmux Config"
cp tmux.conf $HOME/.tmux.conf

echo "Copying Emacs Config"
cp emacs.d/emacs.d/init.el $HOME/.emacs.d/


