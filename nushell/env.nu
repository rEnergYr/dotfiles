##### ------------------------------
##### PATH / Homebrew
##### ------------------------------
$env.PATH = (
  $env.PATH
  | split row (char esep)
  | prepend /opt/homebrew/bin
  | uniq
)

##### ------------------------------
##### Carapace
##### ------------------------------
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"
