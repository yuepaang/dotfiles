#!/bin/bash
# File              : install.sh
# Author            : Yue Peng <yuepaang@gmail.com>
# Date              : 2020-10-12 14:19:05
# Last Modified Date: 2020-10-12 14:19:05
# Last Modified By  : Yue Peng <yuepaang@gmail.com>


set -e

# Utility functions

## For ease of iterative experimentation
doo () {
    $@
    # echo $@
}

command_exists () {
  type "$1" &> /dev/null ;
}

is_osx () {
    if [ "$(uname)" == "Darwin" ]; then
        true
    else
        false
    fi
}

installed () {
  echo -e " ✓ $1 already installed."
}

# This function was originally named errm to be short for "error message", but
# then I realized that it sounds like a person saying, "Errm, excuse me, I don't
# think that's what you meant to do."
errm () {
    2>&1 echo -e "$@"
}

# START HERE.
main () {
    cd $HOME
    install_zsh
    install_rg
    install_universal_ctags
    setup_ctags
    install_plug
    install_tmux
    install_tpm
    setup_tmux_clipboard
    install_tmuxinator
    confirm_no_clobber
    confirm_have_goodies
    install_scm_breeze
    install_diff-so-fancy
    install_neovim
    install_alacritty
    for i in ${DOTS[@]}; do
        link_dot $i
    done
    setup_git_global_ignore
    # TODO: Make sure permissions are legit. .ssh and .ghci, I'm lookin at you.
}

install_zsh() {
    if !(command_exists zsh); then
        doo apt-get install zsh --assume-yes
        doo chsh -s /bin/zsh
    else
        installed 'zsh'
    fi

    # Install oh-my-zsh
    DIR="/Users/$USER/.oh-my-zsh"
    if [ ! -d "$DIR" ]; then
        # https://github.com/ohmyzsh/ohmyzsh#unattended-install
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        # Remove zshrc created by oh-my-zsh by default because we have our own
        doo rm -rf ~/.zshrc
        # Setup theme in oh-my-zsh
        doo cp "$EXPORT_DIR/themes/clean-minimal.zsh-theme" ~/.oh-my-zsh/themes/clean-minimal.zsh-theme
    else
        installed 'oh-my-zsh'
    fi
}

# ripgrep search, faster than ack, ag, silver surfer etc.
# Used by vim.ack plugin to do searching words in a project
install_rg () {
  if !(command_exists rg); then
    doo brew tap burntsushi/ripgrep https://github.com/BurntSushi/ripgrep.git
    doo brew install burntsushi/ripgrep/ripgrep-bin
  else
    installed 'rg'
  fi
}

# Install plug for first time if .vim directory doesn't exist
install_plug() {
  FILE=".vim/autoload/plug.vim"
  if [ ! -f "$FILE" ]; then
    doo curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  else
    installed 'Plug'
  fi
}

install_tmux () {
  if !(command_exists tmux); then
    doo brew install tmux
  else
    installed 'tmux'
  fi
}

install_tpm() {
  DIR=".tmux/plugins/tpm"
  if [ ! -d "$DIR" ]; then
    doo git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins
  else
    installed 'TPM'
  fi
}
ln -s com.yuepaang.shadowsocks-rust.plist ~/Library/LaunchAgents
