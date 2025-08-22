export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
)
source $ZSH/oh-my-zsh.sh

alias l='ls -lh'
alias ll='ls -lah'
alias cd='z'
alias grep='rg'

# set PATH so it includes ~/.local/bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
