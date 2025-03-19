# TODO:
# Investigate VI mode?
# NOTE:
# Ensure emacs mode. Usual default.
bindkey -e

# Load Zsh completion system.
autoload -Uz compinit
compinit

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.

# Prompt
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

# Plugins
source ~/.zsh/git/git.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-you-should-use/you-should-use.plugin.zsh
source ~/.zsh/zsh-bat/zsh-bat.plugin.zsh

# Aliases
alias e='$EDITOR'
alias o='xdg-open'
alias ls='ls --color=auto'
alias rm='echo '\''Use \\rm or trash-put.'\''; false'
alias tm="trash-put"
alias tl="trash-list"
alias te="trash-empty"
alias rt="trash-restore"
alias icat="kitty +kitten icat"
alias dots='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

# Path
export PATH="$PATH:$HOME/.local/bin"

# A function that can be used in a runner, with alias.
hello_world_f() {
    notify-send "Hello World!"
}
alias hello_world='hello_world_f'

# Modern recursive project search and replace.
replace_text_f() {
    if [[ $# -ne 2 ]]; then
        echo "Usage: replace_text_f 'search' 'replace'"
        return 1
    fi

    local search="$1"
    local replace="$2"

    rg -F -l "$search" | xargs sd -s "$search" "$replace"

    # Show changes
    rg -F "$replace"
}
alias re='replace_text_f'

# Modern recursive project search
search_text_f() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: search_text_f 'search'"
        return 1
    fi

    local search="$1"

    rg -F "$search"
}
alias se='search_text_f'

source ~/work/shell-scripts/aliases.zsh
