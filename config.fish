fish_add_path $HOME/.cargo/bin $HOME/.local/bin /opt/bin $HOME/.cabal/bin $HOME/.local/share/gem/ruby/3.0.0/bin

set fish_greeting

alias free='free -m'
alias ls="exa"
alias paru="paru --skipreview --removemake --cleanafter"
alias vim="nvim"
alias x="startx"
alias xclip="xclip -selection clipboard"

alias syncthing-pi="ssh -L 9090:127.0.0.1:8384 gustav@pi"

export EDITOR=nvim
export FZF_CTRL_T_COMMAND="rg --files --hidden"
export GPG_TTY=(tty)
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export XDG_DATA_HOME="$HOME/.local/share"

if status is-interactive
    # Commands to run in interactive sessions can go here
end
