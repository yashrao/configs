echo "Make sure to install nodejs >= 12.12"

https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > $HOME/.cargo/bin/rust-analyzer
chmod +x $HOME/.cargo/bin/rust-analyzer
nvim +'Cocinstall coc-python coc-jedi coc-json coc-tsserver coc-solidity coc-lua' +qa 
pip3 install jedi pynvim
