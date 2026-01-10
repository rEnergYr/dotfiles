##### ------------------------------
##### PATH
##### ------------------------------
$env.PNPM_HOME = ($env.HOME | path join "Library" "pnpm")
$env.PATH = (
  $env.PATH
  | split row (char esep)
  | prepend $env.PNPM_HOME
  | prepend "/usr/local/bin"
  | prepend "/opt/homebrew/bin"
  | uniq
  | str join (char esep)
)

##### ------------------------------
##### Carapace
##### ------------------------------
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"
