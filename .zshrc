

# ~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~
# PS1/PROMPT/prompt = variable for the prompt you see everytime you hit enter
#   see variables: http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{blue}%1~%f%b %\:> '
  # PROMPT explained:
  #   %(?.√.?%?)	if return code ? is 0, show √, else show ?%?
  #   %?	exit code of previous command
  #   %1~	current working dir, shortening home to ~, show only last 1 element
  #   %#	# with root privileges, % otherwise
  #   %B %b	start/stop bold
  #   %F{...}	text (foreground) color, see https://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
  #   %f	reset to default textcolor

# use zsh-integration for git
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git


# ~~~~~~~~~~~~ Options ~~~~~~~~~~~~
# case-insensitive globbing and tab-completion
setopt NO_CASE_GLOB
setopt GLOB_COMPLETE
# auto prepend cd command to typed paths
setopt AUTO_CD
# show command instead of executing when `!!` is executed, eg:
  # ~ >: sudo !!
  # ~ >: sudo systemsetup -getRemoteLogin |
setopt HIST_VERIFY
# allow user to correct commands with [nyae]
setopt CORRECT
# setopt CORRECT_ALL # disabled for now to learn nyae options

# History file options:
# add timestamp to history file entries
setopt EXTENDED_HISTORY
# share history across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
# (the following keep history clean - some are redundant)
# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST
# do not store duplications
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS


# ~~~~~~~~~~~~ Variables ~~~~~~~~~~~~
# parameters used by the zsh shell: http://zsh.sourceforge.net/Doc/Release/Parameters.html#Parameters-Used-By-The-Shell

# set history file and configure sizes
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000
HISTSIZE=2000


# ~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~
#   declare global aliases with `alias -g ll='ls -al'`
#     this tells zsh to replace aliases with the defintion ANYWEHRE in the command
#     instead of only at the beginning of a command
#   suffix aliases effect the last part of the command `alias -s txt="open -t"`

#   in terminal, identify the alias defintion with `which be`
#     (escape the alias with `\` for globals and suffixes: ie. `which \ll`)

alias be="bundle exec"

alias gpom="git pull origin main"
alias gs="git status"
alias gcom="git checkout main"

alias projects="cd ~/Documents/projects"

alias vs="code ."

# ~~~~~~~~~~~~ Functions ~~~~~~~~~~~~
# initialize the zsh completion system (tab-complete options used in `compinstall` command)
# autoload -Uz compinit && compinit

# git functions
git_prune() {
  git fetch origin --prune
  git checkout main
  git branch --merged main | grep -v "* main" | xargs -n 1 git branch -d
}

tweak () {
  git add .
  git ci --amend -C HEAD
}

gfp(){
  git push origin head -f
}

git_wip(){
  echo "committed with wip message"
  git add .
  git commit -m "wip"
}

soft_reset(){
  git reset --soft HEAD~1
}

pretty_log(){
  git log --pretty=oneline
}

#   you may declare functions in a separate file with the `fpath` variable and the `autoload` command
#     see details: https://scriptingosx.com/2019/07/moving-to-zsh-part-4-aliases-and-functions/

# ~~~~~~~~~~~~ load nvm ~~~~~~~~~~~~
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# ~~~~~~~~~~~~ PATH ~~~~~~~~~~~~
# Path for brew
test -d /usr/local/bin && export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
# Path for Heroku
test -d /usr/local/heroku/ && export PATH="/usr/local/heroku/bin:$PATH"
# Path for rabbitmq
test -d /usr/local/sbin/ && export PATH="$PATH:/usr/local/sbin"
# Rbenv
test -d "$HOME/.rbenv/bin" && export PATH="$HOME/.rbenv/bin:$PATH" && eval "$(rbenv init -)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/lindseystevenson/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/lindseystevenson/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/lindseystevenson/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/lindseystevenson/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

