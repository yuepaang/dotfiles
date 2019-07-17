# File              : install.sh
# Author            : Yue Peng <yuepaang@gmail.com>
# Date              : 2019-07-12 11:14:08
# Last Modified Date: 2019-07-12 11:14:08
# Last Modified By  : Yue Peng <yuepaang@gmail.com>

ln -s ~/dotfiles/neovim ~/.config/nvim

# coc.nvim dependencies
curl -sL install-node.now.sh/lts | bash

# exuberant-ctags
# sudo apt install exuberant-ctags

# npm language server
npm i -g bash-language-server
npm install -g dockerfile-language-server-nodejs
npm install -g typescript typescript-language-server
# npm install --global vscode-html-languageserver-bin
# npm install -g json-language-server
# npm install -g yaml-language-server

# Golang
https_proxy=http://127.0.0.1:8118 go get -u golang.org/x/tools/cmd/gopls

# Rust
rustup update
rustup component add rls rust-analysis rust-src

# swap ctrl and caps
setxkbmap -option ctrl:swapcaps

# Chrome extension name
# browser-source-provider (by voldikss)
