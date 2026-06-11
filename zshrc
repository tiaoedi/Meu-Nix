# Load system zsh config (NixOS oh-my-zsh initialization)
[ -f /etc/zshrc ] && source /etc/zshrc

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

#export ZSH="$HOME/.oh-my-zsh"

# Set-up icons for files/directories in terminal
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'

# Starting down here, are set in user.nix

##### Minhas alias #######
alias upall="cd ~/Meu-Nix && git add . && updatef && update && nixpush"
alias update="sudo nixos-rebuild switch --flake /home/pc120/Meu-Nix#Nix"
alias updatef="sudo nix flake update"
alias ff="fastfetch"
alias vnc="vim Meu-Nix/hosts/Nix/config.nix"
alias vnp="vim Meu-Nix/modules/packages.nix"
alias vnf="vim Meu-Nix/flake.nix"
alias vzsh="vim ~/.zshrc"
alias ya="yazi"
alias svim="sudo vim"
alias cm="cmatrix"
alias sr="reboot"
alias ht="htop"
alias flatpaku="flatpak update && flatpak upgrade"
alias nl="sudo nix-env --list-generations --profile /nix/var/nix/profiles/system"
alias ndn="sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations"
alias nrc="sudo nix-env --profile /nix/var/nix/profiles/system --switch-generation"

#youtube download
alias baixarm="yt-dlp --extract-audio --audio-format mp3 "
alias baixarv="yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4"

#ZSH_THEME="xiong-chiamiov-plus"

#plugins=(
#    git
    #zsh-autosuggestions
    #zsh-syntax-highlighting
#)

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r


# Set-up FZF key bindings (CTRL R for fuzzy history finder)
#source <(fzf --zsh)

#HISTFILE=~/.zsh_history
#HISTSIZE=10000
#SAVEHIST=10000
#setopt appendhistory
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/powerlevel10k_modern.omp.json)"

alias updateall="cd ~/Meu-Nix && git add . && updatef && update"

#alias noctsave="noctalia-shell ipc call state all > ~/Meu-Nix/modules/home/noctalia.json && cd ~/Meu-Nix && git add . && update"

#alias update="noctalia-shell ipc call state all > ~/Meu-Nix/modules/home/noctalia.json 2>/dev/null; sudo nixos-rebuild switch --flake /home/pc120/Meu-Nix#Nix"
