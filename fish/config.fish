# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
   fastfetch
end


set -gx EDITOR nvim
set -gx VISUAL nvim

alias vim="nvim"
alias nano="nvim"
alias nv="nvim ."

alias i="sudo pacman -S"
alias s="sudo pacman -Ss"
alias r="sudo pacman -Rns"
alias p="sudo pacman"
fzf --fish | source
