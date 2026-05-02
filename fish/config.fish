# link from ~/.config/fish/config.fish

set -g fish_greeting

starship init fish | source

alias hx helix
alias ls "lsd -l --group-dirs first"

function zen-open
    # Check if a filename was provided
    if count $argv >/dev/null
        # Open the file, silence output, background it, and disown
        zen-browser $argv >/dev/null 2>&1 & disown
    else
        zen-browser >/dev/null 2>&1 & disown
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
