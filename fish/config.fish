# link from ~/.config/fish/config.fish

set -g fish_greeting

starship init fish | source

alias ls "exa -l --group-directories-first"

if status is-interactive
    # Commands to run in interactive sessions can go here
end
