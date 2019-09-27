# Awesome Dotfiles

Simple, but extensive customization of ZSH, TMUX, and Vim. 

[![VideoWalkthrough](https://img.youtube.com/vi/UgDz_9i2nwc/0.jpg)](https://www.youtube.com/watch?v=UgDz_9i2nwc)

## Setup Options

There's 3 ways in which you can use this, depending on how much you think you'll be customizing.

One of the key features is that this implementation stays in sync across all your machines. So depending on how much you'd like to customize your configuration, you have a few options:

* Little Customization: Just clone this repo and jump to [Installation](#installation).
* Mild Customization: [Fork]() this repo, and clone your own fork. Keep an eye on this repo for bugfixes and other improvements that you'd like to incorporate into your fork. Then jump to [Installation](#installation).
* Most Customization: Building your own dotfiles from scratch! Read through these docs, watch the video above, star this repo, and create your own dotfiles! You can add this repository as a [git module](https://git-scm.com/book/en/v2/Git-Tools-Submodules) and source the parts you like. 

If you're unsure, just read the docs, watch the video, clone this repository, and jump to [Installation](#installation).

## Installation

Once the repo is cloned, execute the deploy script:
```
./deploy
```

This script guides you through the following:

1. Checks to see if you have zsh, tmux, and vim installed. 
2. Installs it using your default package manager if you don't have it installed.
3. Checks to see if your default shell is zsh.
4. Sets zsh to your default shell.
5. Backs up your old configuration files.

Pretty convenient for configuring new servers.

# Sumary of Changes

## Basic runtime opperations 

All default dotfiles (`.zshrc`, `.vimrc`, etc) source something within the dotfiles repository. This helps separate changes that are synced across all your machines with system specific changes.

Upon launching a new shell, the first thing that's evaulated is `zshrc_manager.sh`. This script first launches tmux. Then once zsh logs in, within tmux, it updates the dotfiles repository, and sources the changes.

## [Zsh](https://en.wikipedia.org/wiki/Z_shell)

* `cd` has been reassigned to `cd` and `ls`. Every time you navigate to a new directory, it will display the contents of that directory.
* `v` has been aliased too: `vim -p`. This let's you open multiple files in vim as tabs. 

### Prompt

The prompt takes on the form:

```
[plugin, plugin, ...]: 
```

Each plugin is sensitive to where you are and what you're doing, they reveal themselves when it's contextually relevant. Plugins include:

* `PWD plugin`: always present, tells you where you are. Always the first plugin.
* `Status code plugin`: appears anytime a program returns with a non-zero status code. Tells you what status code the program completed with. 
* `Git plugin`: appears when you're in a git repository. Tells you what branch you're on, and how many files have been changed since the last commit.
* `Sudo plugin`: tells you when you can sudo without a password. Or when you're logged in as root.
* `Time plugin`: appears when a program took more than 1s to execute. Tells you how long it took to execute.
* `PID plugin`: appears when you background a task. Tells you what the PID of the task is.

### Keybindings
| Key Stroke | What It Does |
|------------|--------------|
| Ctrl-H     | Runs ``cd ~/`` |
| Ctrl-K     | Runs ``cd ..`` |
| Ctrl-G     | Runs ``git add -A; git commit -v && git push`` |
| Ctrl-V     | Runs ``fc``. Takes last command and puts it in a vim buffer. |
| Ctrl-S     | Add's ``sudo`` to the beginning of the buffer. |
| Ctrl-L     | Run's ``ls``. |
| Ctrl-O     | Equivalent to hitting ``Enter``. |
| Ctrl-P     | Equivalent to pressing ``up arrow``. |

### Plugins

* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions): Searches your history while you type and provides suggestions.
* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/tree/ad522a091429ba180c930f84b2a023b40de4dbcc): Provides fish style syntax highlighting for zsh.
* [ohmyzsh](https://github.com/robbyrussell/oh-my-zsh/tree/291e96dcd034750fbe7473482508c08833b168e3): Borrowed things like tab completion, fixing ls, tmux's vi-mode plugin.
* [vimode-zsh](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/vi-mode) allows you to hit `esc` and navigate the current buffer using vim movement keys.

## [Vim](https://en.wikipedia.org/wiki/Vim_(text_editor))

* Leader key has ben remapped to `,`

## [Tmux](https://en.wikipedia.org/wiki/Tmux)

* Ctrl-B has been remapped to the backtick character (&#96;). If you want to type the actual backtick character (&#96;) itself, just hit the key twice.
* `%` has been remapped to `v`.
* Use vim movement keys for moving between panes. 
* Copy buffer is coppied to xclip.
* Status bar tells you date, time, user, and hostname. Especially useful with nested ssh sessions. 


### Etc
i3-gaps installation: https://gist.github.com/boreycutts/6417980039760d9d9dac0dd2148d4783

One-time setting:
```bash
sudo apt install alarcritty
sudo apt install python3-udiskie
sudo pip install udiskie
sudo apt install w3m w3m-img
sudo apt install feh
sudo pip3 install pywal
sudo apt install i3blocks
sudo apt install conky conky-all
sudo apt install cowsay cmatrix fortune tty-clock
sudo apt install compton 
sudo apt install htop scrot imagemagick
#sudo apt install rxvt-unicode-256color
```

neofetch install:
```bash
# https://github.com/dylanaraps/neofetch/wiki/Installation#universal-install
# sudo add-apt-repository ppa:dawidd0811/neofetch
# sudo apt update
sudo apt install neofetch
```

rofi install (ver 1.5+. ppa maybe only for ubuntu 16.04)
For later version, simple `apt install` is enough)
```bash
#sudo add-apt-repository ppa:jasonpleau/rofi
#sudo apt update
sudo apt install rofi
```

GNOME network configuration network (maybe other applets too):
```
# https://askubuntu.com/questions/598943/how-to-de-uglify-i3-wm
sudo apt-get install lxappearance gtk-chtheme qt4-qtconfig
```

Wallpaper:
```
feh --bg-fill /path/wallpaper.png
```

i3lock
```
sudo apt install libev-dev libxcb-composite0 libxcb-composite0-dev libxcb-xinerama0 libxcb-randr0 libxcb-xinerama0-dev libxcb-xkb-dev libxcb-image0-dev libxcb-util-dev libxkbcommon-x11-dev libjpeg-turbo8-dev libpam0g-dev

git clone https://github.com/PandorasFox/i3lock-color.git
cd i3lock-color
autoreconf --force --install
mkdir build && cd build
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make

sudo cp /usr/bin/i3lock /usr/bin/i3lock_                                     
sudo cp i3lock /usr/bin/i3lock

```

polybar
```bash
sudo apt install cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0 libxcb-composite0-dev
git clone https://github.com/polybar/polybar.git
cd polybar
./build.sh

# to enable siji font
sudo rm /etc/fonts/conf.d/70-no-bitmaps.conf
fc-cache -fv ~/.fonts
```

slop & maim (apt-get is enough for 18.04+)
```bash
sudo apt slop maim
# ## ---- slop ----
# sudo apt-get install libxext-dev
# sudo apt-get install libpng-dev
# sudo apt-get install libimlib2-dev
# sudo apt-get install libglew-dev
# sudo apt-get install libxrender-dev
# sudo apt-get install libxrandr-dev
# sudo apt-get install libglm-dev
# git clone https://github.com/naelstrof/slop.git
# cd slop
# cmake -DCMAKE_INSTALL_PREFIX="/usr" ./
# make && sudo make install
# ## ---- maim ----
# git clone https://github.com/naelstrof/maim.git
# cd maim
# cmake -DCMAKE_INSTALL_PREFIX="/usr" ./
# make && sudo make install
```

