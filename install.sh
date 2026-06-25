#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/.dotfiles"

link() {
  local src="$DOTFILES/$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  ln -sf "$src" "$dst"
  echo "  $dst -> $src"
}

echo "Linking dotfiles..."

link zshrc                   "$HOME/.zshrc"
link vim/vimrc               "$HOME/.vimrc"
link config/gitconfig        "$HOME/.gitconfig"
link config/gitignore        "$HOME/.gitignore"
link config/ctags            "$HOME/.ctags"
link config/gemrc            "$HOME/.gemrc"
link config/irbrc            "$HOME/.irbrc"
link config/pryrc            "$HOME/.pryrc"
link config/rspec            "$HOME/.rspec"
link config/bundle           "$HOME/.bundle/config"
link config/direnvrc         "$HOME/.config/direnv/direnvrc"

mkdir -p "$HOME/bin"
link shell/ssh-linode         "$HOME/bin/ssh-linode"
link shell/ssh-linode-roulette "$HOME/bin/ssh-linode-roulette"

echo "Done."
