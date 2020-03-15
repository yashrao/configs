### Script to setup Fresh Void Linux install

sudo xbps-install -S git
cd ~
git clone git://github.com/bahamas10/vpm.git ~/.bin/
echo "export PATH=\"\$HOME/.bin:\$PATH\" ## For scripts and where vpm is stored" >> ~/.zsh/custom.zsh
sudo vpm install vsv
