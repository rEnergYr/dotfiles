# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# Prompt
neofetch
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/macos.omp.json)"

# Plugins
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Config
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Alias
alias ls="colorls"
alias ll="colorls -l"
alias lld="colorls -l --sd"
alias llf="colorls -l --sf"
alias vim="nvim"
alias cat="bat"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
