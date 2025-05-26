$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.MANPAGER = "nvim +Man!"
$env.path = ($env.path | prepend "~/.local/bin" | prepend "~/.local/share/nvim/mason/bin/" | prepend "~/.cargo/bin/")
$env.PROMPT_COMMAND_RIGHT = ""

$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

alias la = ls -la
alias cat = bat
alias nv = nvim
alias yz = yazi
alias lg = lazygit
alias mkd = mkdir
