# ---------- Aliases ----------
alias ls='eza --icons=auto'
alias ll='eza -lah --icons=auto'
alias la='eza -a --icons=auto'
alias grep='grep --color=auto'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias mkdir='mkdir -p'
alias cat='bat'

# Safer file ops
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# ---------- Path ----------
export PATH=$PATH:/usr/local/go/bin
export PATH="/home/grs/.npm-global/bin:$PATH"

# ---------- Basics ----------
export ZDOTDIR="$HOME"
export EDITOR="micro"
export VISUAL="micro"
export TERMINAL="alacritty"
export BROWSER="vivaldi"

# ---------- History ----------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY

# ---------- Shell behavior ----------
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt COMPLETE_IN_WORD

# Better globbing
setopt EXTENDED_GLOB

# ---------- Completion ----------
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ---------- fzf ----------
if command -v fzf >/dev/null 2>&1; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# ---------- autosuggestions ----------
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# ---------- syntax highlighting (MUST BE LAST) ----------
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

eval "$(starship init zsh)"
export PATH="$HOME/.npm-global/bin:$PATH"

# OpenClaw Completion
source "/home/grs/.openclaw/completions/openclaw.zsh"
