oh-my-posh init pwsh --config "$PSScriptRoot/theme.omp.json" | Invoke-Expression

# eza aliases
Remove-Item Alias:ls -ErrorAction SilentlyContinue
function ls  { eza --icons --group-directories-first @args }
function ll  { eza --icons --group-directories-first -l @args }
function la  { eza --icons --group-directories-first -a @args }
function lla { eza --icons --group-directories-first -la @args }
function lt  { eza --icons --group-directories-first --tree @args }
function l   { eza --icons --group-directories-first -1 @args }