source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

function i
    sudo pacman -S $argv
end

function s
    pacman -Ss $argv
end

function ys
    yay -Ss $argv
end

function yi
    yay -S $argv
end