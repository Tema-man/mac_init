# -----------------------------------------------------------------------------
# ENV vars setup
# >> PATH setup
export LOCAL="/usr/local"
export PATH="$PATH:/sw/bin/:$LOCAL:$LOCAL/bin:$LOCAL/sbin"
export PATH="$PATH:$HOME/.jenv/bin"
# >> zsh home setup
export ZSH="$HOME/.oh-my-zsh"
# >> Android sdk vars setup
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
export GITHUB_TOKEN=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
# -----------------------------------------------------------------------------
# Theme setup
ZSH_THEME="common"
ZSH_THEME="robbyrussell"

# -----------------------------------------------------------------------------
# Zsh setup
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
# DISABLE_UPDATE_PROMPT="true"
# ENABLE_CORRECTION="true"
# HIST_STAMPS="mm/dd/yyyy"

# -----------------------------------------------------------------------------
# Plugins setup
plugins=(
  git
  pj
  git-prompt
)
# >> PJ plugin setup
PROJECT_PATHS=(
  ~/Doscuments
  ~/work
  ~/code
  ~/dev
)

# -----------------------------------------------------------------------------
# User configuration
source $ZSH/oh-my-zsh.sh
# >> prompt settings
PROMPT='🍒 %(?.%F{green}.%F{red}?%?)%f %B%F{130}%1~%f%b %# '
RPROMPT='[$(git_super_status)]'

# -----------------------------------------------------------------------------
# Aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias remove-empty-dirs='find . -type d -empty -delete'
alias cld='~/dev/deep-clean.kts'
alias cldn='~/dev/deep-clean.kts -n'
alias jenvi='eval "$(jenv init -)"'

# -----------------------------------------------------------------------------
# Key Bindings
