source ~/dotfiles/zsh/antigen.zsh
antigen use oh-my-zsh

## Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle docker
antigen bundle fasd

## Syntax highlighting bundle.
## * syntax highlighting should be before history-substring-search
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search

## Load the theme.
## antigen theme robbyrussell

#BULLETTRAIN_PROMPT_ORDER=(
#  time
#  context
#  dir
#  git
#  virtualenv
#)
#BULLETTRAIN_TIME_BG=black
#BULLETTRAIN_TIME_FG=yellow
#BULLETTRAIN_DIR_FG=black
#BULLETTRAIN_VIRTUALENV_BG=yellow
#BULLETTRAIN_VIRTUALENV_FG=black
#antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train

antigen theme denysdovhan/spaceship-prompt

# Tell Antigen that you're done.
antigen apply

# Vars
	HISTFILE=~/.zsh_history
	SAVEHIST=1000
	setopt inc_append_history # To save every command before it is executed
	setopt share_history # setopt inc_append_history

# Aliases
	alias py="python"
	alias v="nvim -p"
	alias g="git status --porcelain"

	# alias gst="git status"
	# alias gc="git clone"
	alias gd="git diff"
	alias ga="git add"
	alias gbd="git branch -D"
	alias gca="git commit -a -m"
	alias gb="git branch"
	alias gba="git branch -a"
	alias gl="git log --pretty='format:%Cgreen%h%Creset %an - %s' --graph"

	# alias gpt="git push --tags"
	# alias gp="git push"
	# alias gpr="git pull-request"
	# alias grh="git reset --hard"

	# alias gcob="git checkout -b"
	# alias gco="git checkout"
	# alias gcp="git cherry-pick"
	# alias docs="rm -fr /tmp/docs && cp -fr docs /tmp/docs && git checkout gh-pages && cp -fr /tmp/docs/* ."
	# alias gpom="git pull origin master"
	# alias gcd='cd "`git rev-parse --show-toplevel`"'
	# alias gdmb='git delete-merged-branches'

	# Below is currently causing problems (fails when you run it anywhere that isn't a git project's root directory)
	# alias vs="v `git status --porcelain | sed -ne 's/^ M //p'`"

    if type nvim > /dev/null 2>&1; then
        alias vim='nvim'
        export VISUAL=nvim; export VISUAL EDITOR=nvim; export EDITOR
    else
	    export VISUAL=vim
    fi

# Settings
source ~/dotfiles/zsh/plugins/fixls.zsh
source ~/dotfiles/zsh/grc.zsh

#Functions
	# Loop a command and show the output in vim
	loop() {
		echo ":cq to quit\n" > /tmp/log/output
		fc -ln -1 > /tmp/log/program
		while true; do
			cat /tmp/log/program >> /tmp/log/output ;
			$(cat /tmp/log/program) |& tee -a /tmp/log/output ;
			echo '\n' >> /tmp/log/output
			vim + /tmp/log/output || break;
			rm -rf /tmp/log/output
		done;
	}

 	## Custom cd
 	#c() {
 	#	cd $1;
 	#	ls;
 	#}
 	#alias cd="c"

# For vim mappings:
	stty -ixon

# Completions
# These are all the plugin options available: https://github.com/robbyrussell/oh-my-zsh/tree/291e96dcd034750fbe7473482508c08833b168e3/plugins
#
# Edit the array below, or relocate it to ~/.zshrc before anything is sourced
# For help create an issue at github.com/parth/dotfiles

autoload -U compinit

# plugins=(
# 	docker
#     docker-compose
# )
#
# for plugin ($plugins); do
#     fpath=(~/dotfiles/zsh/plugins/oh-my-zsh/plugins/$plugin $fpath)
# done
#
# compinit
#
# export ZSH=~/dotfiles/zsh/plugins/oh-my-zsh
# ZSH_THEME="agnoster"
# source ~/dotfiles/zsh/plugins/oh-my-zsh/oh-my-zsh.sh
#
# source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/history.zsh
# source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/key-bindings.zsh
# source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/completion.zsh
# #source ~/dotfiles/zsh/plugins/vi-mode.plugin.zsh
# source ~/dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ~/dotfiles/zsh/keybindings.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# I think substring finder is better than begining below.
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

## Fix for arrow-key searching
## start typing + [Up-Arrow] - fuzzy find history forward
#if [[ "${terminfo[kcuu1]}" != "" ]]; then
#	autoload -U up-line-or-beginning-search
#	zle -N up-line-or-beginning-search
#	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
#fi
## start typing + [Down-Arrow] - fuzzy find history backward
#if [[ "${terminfo[kcud1]}" != "" ]]; then
#	autoload -U down-line-or-beginning-search
#	zle -N down-line-or-beginning-search
#	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
#fi

#source ~/dotfiles/zsh/prompt.sh
export PATH=$PATH:$HOME/dotfiles/utils

# Cuda Toolkit
export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64"
export PATH=$PATH:$CUDA_HOME/bin

# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
FILE_VIRTUALENV_WR=/usr/local/bin/virtualenvwrapper.sh
if test -f "$FILE_VIRTUALENV_WR"; then
    source /usr/local/bin/virtualenvwrapper.sh
else
    source $HOME/.local/bin/virtualenvwrapper.sh
fi

#export LD_PRELOAD="/usr/lib/libtcmalloc_minimal.so.4"

# d-bus notification (notify-osd in gnome, dunst in i3)
# https://askubuntu.com/questions/634797/notify-osd-replaced-with-dunst-after-switching-back-to-unity-from-i3wm
# export XDG_DATA_HOME=$HOME/.local/share

# d-bus notification
SERVICE=org.knopwob.dunst 	# use dunst
# SERVICE=					# use default
mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services"
ln -sTf \
    "/usr/share/dbus-1/services/${SERVICE:-org.Freedesktop.Notifications}.service" \
    "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services/org.freedesktop.Notifications.service"

# for docker complete plugin. It activates only with the following.
# https://github.com/docker/cli/issues/26
autoload -Uz compinit
compinit


## HSTR configuration - add this to ~/.zshrc
## (02/04/2020, I think "fzf" is better than "hstr". So disable \C-r.
if type hstr > /dev/null 2>&1; then
    alias hh=hstr                    # hh to be alias for hstr
    setopt histignorespace           # skip cmds w/ leading space from history
    export HSTR_CONFIG=hicolor       # get more colors
    #`bindkey -s "\C-r" "\C-a hstr -- \C-j"  # bind hstr to Ctrl-r (for Vi mode check doc)
fi

## history-substring-search configuration
export HISTORY_SUBSTRING_SEARCH_FUZZY=1


