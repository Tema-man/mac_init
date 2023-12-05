# Mac initial setup script

A small script for automate new mac books setup

Contains:
 - **mac_setup.sh** a shell script to install all the necessary programs and settings
 - **BlueSky.icls** a color scheme for a intellij idea based IDEs
 - **iterm_profile.json** a profile for iterm terminal emulator
 - dot files for zsh and vim

 The script does:
 - Check for Mac updates and installs it if required
 - Installs xcode dev tools
 - Creates a ~/Developer directory
 - Installs (homebrew)[https://brew.sh/]
 - Setups java 
    - Installs (jenv)[https://www.jenv.be/]
    - Installs Java latest and 11th
 - Setups terminal
    - Installs (iterm2)[https://iterm2.com/]
    - Installs (zsh)[https://www.zsh.org/] and sets it to be a default shell
    - Installs (oh-my-zsh)[https://ohmyz.sh/]
    - Copy **.zshrc** to your home directory
 - Setups vim
    - Installs (vundle)[https://github.com/VundleVim/Vundle.vim] a vim's plugins manager
    - Copy **.vimrc** to your home directory
    - Installs basic vim plugins
 - Installs apps
    - (Google chrome)[https://www.google.com/chrome/]
    - (Jetbrains toolbox)[https://www.jetbrains.com/toolbox-app/]
    - (Obsidian)[https://obsidian.md/]


