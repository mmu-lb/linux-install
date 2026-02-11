# link from ~/.config/fish/config.fish

set -g fish_greeting

starship init fish | source

alias hx helix
alias ls "lsd -l --group-dirs first"

if status is-interactive
    # Commands to run in interactive sessions can go here
end
