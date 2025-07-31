# export HISTSIZE=10000
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh)"
fi
eval "$(zoxide init zsh)"

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/zen.toml)"

alias c="clear && tmux clear-history 2> /dev/null"
alias clear="clear && tmux clear-history 2> /dev/null"
alias pb="pbcopy"

alias n="nvim"
alias nvim="nvim"
alias ni="nvim"
alias vi="nvim"
# alias vi='NVIM_APPNAME="VitaVim" nvim'
# alias vim='NVIM_APPNAME="VitaVim" nvim'

alias ghost="ghostty"
alias nghost="cd ~/.config/ghostty && vi"
alias nghos="cd ~/.config/ghostty && vi"

alias nzsh="vi ~/.zshrc"
alias nconfig="cd ~/.config/nvim/ && n"
alias vconfig="cd ~/.config/VitaVim/ && vi"

alias ga="git add"
alias gf="git fetch"
alias gc="git commit"
alias gs="git status"
alias gss="git status -s"

alias ls="eza --icons --group-directories-first"
alias ll="eza -l --icons --group-directories-first"
alias la="eza -al --icons --group-directories-first"
# A function to run eza with a dynamic tree level
lta() {
  # Runs eza with a specified level, or defaults to 4 if no level is given.
  eza --long --tree --icons --level=${1:-4}
}
# alias lat="eza --long --tree --icons --level=4"

alias build="bun run build"

alias hci="cd ~/code/smart/hci"
alias hci_sql="cd ~/code/sql/hci/ && nvim"
alias hciSql="cd ~/code/sql/hci/ && nvim"
alias notes="cd ~/code/notes && vi"

alias f="~/scripts/tmux-sessionizer"
alias sf='sesh connect $(sesh list | fzf)'

alias kinesis="cd ~/code/kinesis/Adv360-Pro-ZMK/ && nvim"
alias corne="cd ~/code/keyboards/corne_zmk_test/ && nvim"

# atuin
export ATUIN_HOME="$HOME/.atuin/bin/"
export PATH="$ATUIN_HOME:$PATH"

# volta
PATH="$HOME/.volta/bin:$PATH"

# dotnet
export PATH="/usr/local/share/dotnet/:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"

# go
export GOPATH=$HOME/code/go
export PATH=$GOPATH:$PATH
export PATH=$HOME/code/go/bin:$PATH

# HCI
export HCI_APPLICATION_ENVIRONMENT=Local
export ASPNETCORE_ENVIRONMENT=Local

# blink cursor on tmux 1 = block, 2 = vertical bar
echo -ne "\e[1 q"
precmd() { echo -ne "\e[1 q"; }

bindkey -v
setopt AUTO_CD
setopt NO_BEEP
setopt AUTO_MENU

unsetopt CORRECT
# bun completions
[ -s "/Users/srocha/.bun/_bun" ] && source "/Users/srocha/.bun/_bun"


# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# zig
export PATH="$HOME/zig/0.13.0/files:$PATH"
alias zig="$HOME/zig/0.13.0/files/zig"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.cargo/bin/cargo:$PATH"
# export PATH="$HOME/.cargo:$PATH"

# bit
case ":$PATH:" in
  *":/Users/srocha/bin:"*) ;;
  *) export PATH="$PATH:/Users/srocha/bin" ;;
esac
# bit end

# Added by Windsurf
export PATH="/Users/srocha/.codeium/windsurf/bin:$PATH"

# react native config
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# doom emacs
# export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"

# popup history
export FZF_CTRL_R_OPTS="--reverse"
export FZF_TMUX_OPTS="-p"

# zoxide
export _ZO_EXCLUDE="*/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# . "$HOME/.atuin/bin/env"



eval "$(atuin init zsh)"

# Add this to your ~/.zshrc
# if [ -n "$TMUX" ]; then
#   # Function to update tmux session name
#   update_tmux_session_name() {
#     tmux rename-session "$(basename "$PWD")"
#   }
#   # Add the function to the precmd hook
#   # precmd_functions+=(update_tmux_session_name)
# fi

# sesh_connect_basename_wrapper: Connects to a sesh/tmux session,
#                                or creates a new one named after the
#                                basename of the selected path.


alias claude="~/.claude/local/claude"

export EDITOR='nvim'
