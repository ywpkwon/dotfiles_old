time_out () { perl -e 'alarm shift; exec @ARGV' "$@"; }

# Run tmux if exists
if [ -z "$NO_TMUX" ]; then
    if command -v tmux>/dev/null; then
        # Note that tmux removes (doesn't propagate)
        # all environment variable. So you need to forward.

        ENV=""
        if [[ $DOTFILE_SYNC == true ]]; then
            ENV="DOTFILE_SYNC=true ${ENV}"
        fi
        if [[ $neofetch == true ]]; then
            ENV="neofetch=true ${ENV}"
        fi

        [ -z "$TMUX" ] && exec tmux new "${ENV} zsh"
    else
        echo "tmux not installed. Run ./deploy to configure dependencies"
    fi
fi


if [[ $DOTFILE_SYNC == true ]]; then
    echo "Updating configuration (dotfiles) ..."
    #(cd ~/dotfiles && time_out 3 git pull && time_out 3 git submodule update --init --recursive)
    (cd ~/dotfiles && git pull && git submodule update --init --recursive)
fi

if [[ $neofetch == true ]]; then
    echo ''
    neofetch --block_range 0 15
fi

source ~/dotfiles/zsh/zshrc.sh

