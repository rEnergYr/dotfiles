##### ------------------------------
##### Env
##### ------------------------------
$env.config.show_banner = false

##### ------------------------------
##### Starship
##### ------------------------------
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")


##### ------------------------------
##### Carapace
##### ------------------------------
source $"($nu.cache-dir)/carapace.nu"

##### ------------------------------
##### Neofetch
##### ------------------------------
neofetch --ascii ~/.dotfiles/neofetch/ascii.txt

##### ------------------------------
##### Alias 
##### ------------------------------
alias l   = ls
alias ll  = ls -l
alias n   = nvim
alias cat = bat
alias d   = docker
alias p   = pnpm
alias ai  = do { clear; copilot --model claude-sonnet-4.5 }

def dev [] {
    tmux new-session -d -s dev -n nvim
    tmux send-keys -t dev:nvim "n" C-m
    tmux new-window -t dev -n ai
    tmux send-keys -t dev:ai "ai" C-m
    tmux select-window -t dev:1
    tmux attach-session -t dev
}

def s [] {
    let selection = (fzf --preview "bat --style=numbers --color=always {}")
    if $selection != "" {
        nvim $selection
    }
}
