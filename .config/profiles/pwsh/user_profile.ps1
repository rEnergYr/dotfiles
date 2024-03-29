# Load prompt config
oh-my-posh init pwsh --config "~\.config\powershell\pwsh.omp.json" | Invoke-Expression

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History

# Modules
Import-Module ~\scoop\apps\terminal-icons\current\Terminal-Icons

# Alias
Set-Alias ll ls
Set-Alias vim nvim   
Set-Alias http curlie
