# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# Plugins
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"

# Prompt
neofetch
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/zsh.omp.json)"

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

# Ruby with homebrew
export PATH="/opt/homebrew/opt/ruby/bin:$PATH" && PATH=$(ruby -e 'puts Gem.bindir'):$PATH

# Bun with homebrew
export PATH="${HOME}/.bun/bin:$PATH"

[[ -f "$HOME/fig-export/dotfiles/dotfile.zsh" ]] && builtin source "$HOME/fig-export/dotfiles/dotfile.zsh"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
