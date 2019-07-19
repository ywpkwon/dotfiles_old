time_out () { perl -e 'alarm shift; exec @ARGV' "$@"; }

if [[ $neofetch == true ]]; then
    neofetch
else
    # Run tmux if exists
    if command -v tmux>/dev/null; then
    	[ -z $TMUX ] && exec tmux
    else
    	echo "tmux not installed. Run ./deploy to configure dependencies"
    fi
fi
echo "Updating configuration"
#(cd ~/dotfiles && time_out 3 git pull && time_out 3 git submodule update --init --recursive)
(cd ~/dotfiles && git pull && git submodule update --init --recursive)
source ~/dotfiles/zsh/zshrc.sh
