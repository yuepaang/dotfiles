ln -s ~/dotfiles/neovim ~/.config/nvim

# npm language server
# npm i -g bash-language-server
# npm install -g dockerfile-language-server-nodejs
npm install -g typescript typescript-language-server
# npm install --global vscode-html-languageserver-bin
# npm install -g json-language-server
# npm install -g yaml-language-server

# Potential Go Problem in Mac
# cd /Library/Developer/CommandLineTools/Packages

cp ./badwolf.vim ~/.config/nvim/pack/minpac/start/lightline.vim/autoload/lightline/colorscheme/

# Rust
rustup update
rustup component add rls rust-analysis rust-src
