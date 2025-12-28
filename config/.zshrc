source ~/.cache/hellwal/variables.sh
sh ~/.cache/hellwal/terminal.sh

# Lines configured by zsh-newuser-install
setopt HIST_IGNORE_DUPS HIST_FIND_NO_DUPS HIST_IGNORE_ALL_DUPS
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

setopt autocd beep extendedglob nomatch
unsetopt notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/swxye/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

prompt='[%B%F{magenta}%n%f%b@%B%F{cyan}%m%f%b %B%~%b] '

alias hx='helix'
alias cat='bat'
alias ls='eza --grid -a'
alias sudo='doas'
alias sudoedit='doasedit'
