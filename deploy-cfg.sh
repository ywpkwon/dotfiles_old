ln -sf ~/dotfiles/cfg/.config/i3 ~/.config
ln -sf ~/dotfiles/cfg/.config/conky ~/.config
ln -sf ~/dotfiles/cfg/.Xresources ~
ln -sf ~/dotfiles/cfg/.urxvt ~
ln -sf ~/dotfiles/cfg/.wallpapers ~
ln -sf ~/dotfiles/cfg/.note.txt ~
rsync -rav ~/dotfiles/cfg/.fonts/* ~/.fonts/

echo '---------------- sync done ----------------'
echo 'Alt+Shift+r              for i3 reload'
echo 'fc-cache -fv ~/.fonts    for font reload'
echo 'xrdb ~/.Xresource        for terminal reload'
