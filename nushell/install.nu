#!/usr/bin/env nu

##### --------------------------------------------------------------
##### Script to install essential packages using Homebrew
##### --------------------------------------------------------------
let packages = [
    "starship"
    "tmux"
    "carapace"
    "neovim"
    "media-control"
    "fd"
    "fzf"
    "ripgrep"
    "lazygit"
    "lazydocker"
    "lazysql"
    "copilot-cli"
    "neofetch"
    "httpie"
    "bat"
    "rust"
    "node"
    "pnpm"
    "mole"
]

##### ------------------------------
##### Install each package
##### ------------------------------
print "\n📦 Installing packages...\n"
for package in $packages {
    print $"Installing ($package)..."
    let result = (brew install $package --quiet e>| complete)
    if $result.exit_code != 0 {
        print $"❌ Error installing ($package):"
        print $result.stderr
    }
}

print "\n🎉 All packages installed!"
