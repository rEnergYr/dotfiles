# Go to home folder (especially for WSL)
cd ~/

# Plugins
source "$HOME/.config/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Prompt
neofetch
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/zsh.omp.json)"

# Alias
alias ls="colorls"
alias ll="colorls -l"
alias lld="colorls -l --sd"
alias llf="colorls -l --sf"
alias vim="nvim"
alias cat="batcat"
