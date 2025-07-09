$env.config.show_banner = false
$env.config.buffer_editor = "helix"
$env.path = ($env.path | prepend "~/.local/bin" | prepend "~/.cargo/bin/")
$env.PROMPT_COMMAND = { || $"($env.PWD | path basename)" }
$env.PROMPT_COMMAND_RIGHT = ""

$env.EDITOR = "helix"
$env.VISUAL = "helix"

alias la = ls -la
alias cat = bat
alias hx = helix
alias yz = yazi
alias lg = lazygit
alias mkd = mkdir
