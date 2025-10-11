#!/usr/bin/env bash
if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

# Optionale Zusatzmodule
mkdir -p "${ZDOTDIR:-$HOME}/.zprezto/contrib"
cd "${ZDOTDIR:-$HOME}/.zprezto/contrib"
[ ! -d zsh-autosuggestions ] && git clone https://github.com/zsh-users/zsh-autosuggestions
[ ! -d zsh-syntax-highlighting ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting
