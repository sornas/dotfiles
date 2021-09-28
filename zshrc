s() {
  case "$1" in
    u)
      shift
      case "$1" in
        r)
          shift
          systemctl --user restart $@
          ;;
        *)
          shift
          ;;
      esac
      ;;
    *)
      shift
      ;;
  esac
}

linklb() {
    ln -s "$PWD/$1" "$HOME/.local/bin/"
}

export _JAVA_AWT_WM_NONREPARENTING=1

## Options section
#setopt correct           # Auto correct mistakes
setopt extendedglob      # Extended globbing. Allows using regular expressions with *
setopt nocaseglob        # Case insensitive globbing
setopt rcexpandparam     # Array expension with parameters
setopt nocheckjobs       # Don't warn about running processes when exiting
setopt numericglobsort   # Sort filenames numerically when it makes sense
setopt nobeep            # No beep
setopt appendhistory     # Immediately append history instead of overwriting
setopt histignorealldups # If a new command is a duplicate, remove the older one
setopt rmstarsilent      # Dont confirm on `rm (.*)\*(.*)`
#setopt autocd            # if only directory path is entered, cd there.

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"   # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                        # automatically find new executables in path

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
alias vim=nvim
export EDITOR=nvim
# export VISUAL=nvim
WORDCHARS=${WORDCHARS//\/[&.;]}                           # Don't consider certain characters part of the word

export XDG_DATA_HOME="$HOME/.local/share"

## Keybindings section
bindkey   -e
bindkey   '^[[7~' beginning-of-line                 # Home key
bindkey   '^[[H'  beginning-of-line                 # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line    # [Home] - Go to beginning of line
fi
bindkey   '^[[8~' end-of-line                       # End key
bindkey   '^[[F'  end-of-line                       # End key
if [[ "${terminfo[kend]}"  != "" ]]; then
  bindkey "${terminfo[kend]}"  end-of-line          # [End] - Go to end of line
fi
bindkey   '^[[2~' overwrite-mode                    # Insert key
bindkey   '^[[3~' delete-char                       # Delete key
bindkey   '^[[C'  forward-char                      # Right key
bindkey   '^[[D'  backward-char                     # Left key
bindkey   '^[[5~' history-beginning-search-backward # Page up key
bindkey   '^[[6~' history-beginning-search-forward  # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word
bindkey '^[Od' backward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^H' backward-kill-word # delete previous word with ctrl+backspace
bindkey '^[[Z' undo             # Shift+tab undo last action

## Alias section 
# default flags
alias cp="cp -i"     # Confirm before overwriting something
alias df='df -h'     # Human-readable sizes
alias free='free -m' # Show sizes in MB
alias xclip="xclip -selection clipboard"
alias paru="paru --skipreview"

# overriding commands
alias ls="exa"

## Function section

# youtube-dl music-single
function yt-s {
    pushd /data/music/youtube-dl/singles
    youtube-dl -f bestaudio $1
    popd
}

# Theming section  
autoload -U compinit colors zcalc
compinit -d
colors

# enable substitution for prompt
setopt prompt_subst

# Maia prompt
PROMPT=""
if [[ -n $SSH_CONNECTION ]]; then
    PROMPT+="$(hostname):"
fi
PROMPT+="%B%{$fg[cyan]%}%(3~|%-1~/.../%1~|%~)%u%b $%{$reset_color%}%b "

# Right prompt with exit status of previous command if not successful
#RPROMPT="%{$fg[red]%} %(?..[%?])" 

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export GPG_TTY=$(tty)

## Plugins section: Enable fish style features
# Use syntax highlighting
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

local HAS_HISTORY=0
# Use history substring search
if [ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
	source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
	HAS_HISTORY=1
fi

if [ -d /usr/share/fzf ]; then
	source /usr/share/fzf/completion.zsh
	source /usr/share/fzf/key-bindings.zsh
fi

zmodload zsh/terminfo
# bind UP and DOWN arrow keys to history substring search
if [ $HAS_HISTORY -eq 1 ]; then
	bindkey "$terminfo[kcuu1]" history-substring-search-up
	bindkey "$terminfo[kcud1]" history-substring-search-down
	bindkey '^[[A' history-substring-search-up                      
	bindkey '^[[B' history-substring-search-down
fi

# Apply different settigns for different terminals
case $(basename "$(cat "/proc/$PPID/comm")") in
  login)
        alias x='startx ~/.xinitrc dwm && clear'
        alias xx='startx ~/.xinitrc && clear'
        export PATH="/home/gustav/.local/bin/statusbar:/home/gustav/liu/tddb68/pintos/src/utils:/home/gustav/script:/home/gustav/.local/bin:/home/gustav/.cargo/bin:/home/gustav/go/bin:/home/gustav/.gem/ruby/2.7.0/bin:/home/gustav/.emacs.d/bin:$PATH"
        export PATH="$PATH:/opt"
    ;;
  *)
        # Use autosuggestion
        #source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
        #ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
        #ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
    ;;
esac
