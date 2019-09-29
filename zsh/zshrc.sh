# Vars
	HISTFILE=~/.zsh_history
	SAVEHIST=1000
	setopt inc_append_history # To save every command before it is executed
	setopt share_history # setopt inc_append_history

# Aliases
	alias py="python"
	alias v="vim -p"
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

# Settings
	export VISUAL=vim

source ~/dotfiles/zsh/plugins/fixls.zsh

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

 	# Custom cd
 	c() {
 		cd $1;
 		ls;
 	}
 	alias cd="c"

# For vim mappings:
	stty -ixon

# Completions
# These are all the plugin options available: https://github.com/robbyrussell/oh-my-zsh/tree/291e96dcd034750fbe7473482508c08833b168e3/plugins
#
# Edit the array below, or relocate it to ~/.zshrc before anything is sourced
# For help create an issue at github.com/parth/dotfiles

autoload -U compinit

plugins=(
	docker
)

for plugin ($plugins); do
    fpath=(~/dotfiles/zsh/plugins/oh-my-zsh/plugins/$plugin $fpath)
done

compinit

export ZSH=~/dotfiles/zsh/plugins/oh-my-zsh
ZSH_THEME="agnoster"
source ~/dotfiles/zsh/plugins/oh-my-zsh/oh-my-zsh.sh

source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/history.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/key-bindings.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/completion.zsh
source ~/dotfiles/zsh/plugins/vi-mode.plugin.zsh
source ~/dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/keybindings.sh
source ~/dotfiles/zsh/grc.zsh

# Fix for arrow-key searching
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
	autoload -U up-line-or-beginning-search
	zle -N up-line-or-beginning-search
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
	autoload -U down-line-or-beginning-search
	zle -N down-line-or-beginning-search
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

#source ~/dotfiles/zsh/prompt.sh
export PATH=$PATH:$HOME/dotfiles/utils

# Cuda Toolkit
export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64"
export PATH=$PATH:$CUDA_HOME/bin

# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

#export LD_PRELOAD="/usr/lib/libtcmalloc_minimal.so.4"

# d-bus notification (notify-osd in gnome, dunst in i3)
# https://askubuntu.com/questions/634797/notify-osd-replaced-with-dunst-after-switching-back-to-unity-from-i3wm
# export XDG_DATA_HOME=$HOME/.local/share

# d-bus notification
# use dunst
SERVICE=org.knopwob.dunst
# use default
# SERVICE=
mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services"
ln -notify-osd-replaced-with-dunst-after-switching-back-to-unity-from-i3wm \
    "/usr/share/dbus-1/services/${SERVICE:-org.Freedesktop.Notifications}.service" \
    "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services/org.freedesktop.Notifications.service"
    