#!/bin/sh

ln -sf ~/dotfiles/cfg/.config/i3 ~/.config
ln -sf ~/dotfiles/cfg/.config/conky ~/.config
ln -sf ~/dotfiles/cfg/.config/rofi ~/.config
ln -sf ~/dotfiles/cfg/.config/polybar ~/.config
ln -sf ~/dotfiles/cfg/.config/compton.conf ~/.config
ln -sf ~/dotfiles/cfg/.config/dunst ~/.config
ln -sf ~/dotfiles/cfg/.config/alacritty ~/.config
ln -sf ~/dotfiles/cfg/.config/nvim ~/.config
ln -sf ~/dotfiles/cfg/.config/ranger/rc.conf ~/.config/ranger
ln -sf ~/dotfiles/cfg/.config/ranger/scope.sh ~/.config/ranger
ln -sf ~/dotfiles/cfg/.fonts ~
ln -sf ~/dotfiles/cfg/.Xresources ~
ln -sf ~/dotfiles/cfg/.urxvt ~
ln -sf ~/dotfiles/cfg/.wallpapers ~
ln -sf ~/dotfiles/cfg/.notes.txt ~
ln -sf ~/dotfiles/cfg/.conky ~
ln -sf ~/pCloudDrive/okular/docdata ~/.kde/share/apps/okular
# rsync -rav ~/dotfiles/cfg/.fonts/* ~/.fonts/

echo '---------------- sync done ----------------'
echo 'Alt+Shift+r              for i3 reload'
echo 'fc-cache -fv ~/.fonts    for font reload'
echo 'xrdb ~/.Xresources       for terminal reload'
