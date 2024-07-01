# prompt config
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh)"
fi

# Oh my posh theme
eval "$(oh-my-posh init zsh --config ~/.mytheme.omp.toml)"

# Set zinit home
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit if is not there yet
if [[ ! -d "${ZINIT_HOME}" ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

#Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit wait lucid for \
        OMZL::git.zsh \
  atload"unalias grv" \
        OMZP::git
# Load zsh-completions
autoload -U compinit && compinit

# Complation styling
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Aliases
alias zshconfig="nvim ~/.zshrc"
alias shreload="source ~/.zshrc"
alias ls="ls --color"

# History settings
HISTSIZE=5000
HITSTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups

# Homebrew install
#eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# NVM setup
export NVM_DIR="$HOME/.nvm"
#[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
### End of Zinit's installer chunk

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/home/juanesech/.local/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/juanesech/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# Shell integrations
eval "$(zoxide init zsh)"
source /usr/share/nvm/init-nvm.sh
