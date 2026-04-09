# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi

zstyle ':z4h:' auto-update      'no'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'mac'

# Don't start tmux.
zstyle ':z4h:' start-tmux       no

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'yes'

# Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv'         enable 'no'
# Show "loading" and "unloading" notifications from direnv.
# zstyle ':z4h:direnv:success' notify 'yes'

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# SSH when connecting to these hosts.
# zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
# zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
# zstyle ':z4h:ssh:*'                   enable 'no'

# Send these files over to the remote host when connecting over SSH to the
# enabled hosts.
# zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Extend PATH.
path=(~/bin $path)

# Export environment variables.
export GPG_TTY=$TTY
export EDITOR=nvim

# Source additional local files if they exist.
z4h source ~/.env.zsh
source ~/.zsh-defer/zsh-defer.plugin.zsh

# Define key bindings.
z4h bindkey undo Ctrl+/   Shift+Tab  # undo the last command line change
z4h bindkey redo Option+/            # redo the last undone command line change

z4h bindkey z4h-cd-back    Shift+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Shift+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Shift+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Shift+Down   # cd into a child directory

# Define aliases.
alias tree='eza --tree'
alias python=python3
alias ls='eza --icons=auto'
alias l='ls -lh'     #size,show type,human readable
alias la='ls -lAh'   #long list,show almost all,show type,human readable
alias ll='ls -l'      #long list
alias cd=z
alias tf='terraform'
alias tfa='terraform apply'
alias tfaa='terraform apply -auto-approve'
alias tfd='terraform destroy'
alias 'tfd!'='terraform destroy -auto-approve'
alias tff='terraform fmt'
alias tffr='terraform fmt -recursive'
alias tfi='terraform init'
alias tfiu='terraform init -upgrade'
alias tfo='terraform output'
alias tfp='terraform plan'
alias tfs='terraform state'
alias tfsh='terraform show'
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gco='git checkout'
alias gclean='git clean --interactive -d'
alias gc='git commit --verbose'
alias gd='git diff'
alias gm='git merge'
alias gl='git pull'
alias gp='git push'
alias gst='git status'
alias c='clear'
alias diff='diff --color=always'
alias cat='bat'
alias k='kubectl'
alias get_idf='. $HOME/esp/esp-idf/export.sh'

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu

# Initialise shell tools.
eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"

# asdf shims and completions.
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
autoload -Uz compinit && compinit

# Deferred plugin loading.
zsh-defer z4h load ~/.autoswitch_virtualenv
zsh-defer z4h source ~/.autoswitch_virtualenv/autoswitch_virtualenv.plugin.zsh

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' fzf-bindings tab:repeat

# --- fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

export BAT_THEME=tokyonight_night

# =============================================================================
# OS-specific configuration
# =============================================================================

if [[ "$(uname)" == "Darwin" ]]; then
  # dbt Fusion extension
  if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$PATH:$HOME/.local/bin"
  fi
  alias dbtf="$HOME/.local/bin/dbt"
  alias dbt-cloud=dbt

  # Go binaries
  export PATH="$HOME/go/bin:$PATH"

elif [[ "$(uname)" == "Linux" ]]; then
  # Atuin binary (installed via curl installer, not in system PATH by default)
  . "$HOME/.atuin/bin/env"

  # opencode
  export PATH="$HOME/.opencode/bin:$PATH"

  # Go via asdf (version-pinned)
  export PATH="$HOME/.asdf/installs/golang/1.25.5/bin:$PATH"
fi

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi
