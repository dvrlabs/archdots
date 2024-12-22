# TODO:
# Investigate VI mode?
# NOTE:
# Ensure emacs mode. Usual default.
bindkey -e

# Load Zsh completion system.
autoload -Uz compinit
compinit

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
alias ls='ls --color=auto'
alias tm="trash-put"
alias rm='echo '\''Use \\rm or trash-put.'\''; false'
alias tl="trash-list"
alias te="trash-empty"
alias icat="kitty +kitten icat"
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

# Path
export PATH="$PATH:$HOME/.local/bin"


# Example of running script via the launcher.
hello_world_f() {
    notify-send "Hello World!"
}
alias hello_world='hello_world_f'
