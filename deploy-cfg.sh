#!/bin/sh
if [ ! -d "$HOME/.config" ]; then
    echo "mkdir ~/.config"
    mkdir $HOME/.config
fi
ln -sf  ~/dotfiles/cfg/config/i3 ~/.config/
ln -sf  ~/dotfiles/cfg/config/i3blocks ~/.config/
ln -sf  ~/dotfiles/cfg/config/rofi ~/.config/
ln -sf  ~/dotfiles/cfg/config/polybar ~/.config/
ln -sf  ~/dotfiles/cfg/config/compton.conf ~/.config/
ln -sf  ~/dotfiles/cfg/config/dunst ~/.config/
ln -sf  ~/dotfiles/cfg/config/alacritty ~/.config/
ln -sf  ~/dotfiles/cfg/config/nvim ~/.config/
ln -sf  ~/dotfiles/cfg/config/ranger ~/.config/
ln -sf  ~/dotfiles/cfg/config/kitty ~/.config/
ln -sf  ~/dotfiles/cfg/neofetch ~/.config/
ln -sf  ~/dotfiles/cfg/config/dir_colors ~/.dir_colors
ln -sfn ~/dotfiles/cfg/urxvt ~/.urxvt
ln -sfn ~/dotfiles/cfg/wallpapers ~/.wallpapers
ln -sf  ~/dotfiles/cfg/.fonts ~
ln -sf  ~/dotfiles/cfg/.Xresources ~
ln -sf  ~/dotfiles/cfg/.notes.txt ~
ln -sf  ~/dotfiles/cfg/.conky ~
#ln -sf ~/pCloudDrive/okular/docdata ~/.kde/share/apps/okular/
#ln -sf ~/dotfiles/cfg/config/conky ~/.config/
# rsync -rav ~/dotfiles/cfg/.fonts/* ~/.fonts/

echo '---------------- sync done ----------------'
echo 'Alt+Shift+r              for i3 reload'
echo 'fc-cache -fv ~/.fonts    for font reload'
echo 'xrdb ~/.Xresources       for terminal reload'
