#!/usr/bin/env bash
# constants
# Reset
NC='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

S="\n${UBlue}"
E="${NC}\n"
SSP="\n${Cyan}~~~>"

# Begginning of script
clear
printf "\n${UGreen}👋 Hi there! let's prepare this machine for a development!${E}"
printf "${S}🍏 Let's start with a xcode dev tools. Installing..${E}"

# xCode tools
xcode-select --install

# dev directory
cd ~
if [ ! -d "dev" ] ; then
    printf "${S}📂 Directory ~/dev does not exists. Creating..${E}"
    mkdir dev
fi

# Homebrew
which -s brew
if [[ $? != 0 ]] ; then
    printf "${S}🍺 Homebrew is not installed. Installing Homebrew${E}"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew update

# Java
printf "${S}☕ Installing java and jenv${E}"
printf "${SSP} ☕ ..installing jenv${E}"
brew install jenv
printf "${SSP} ☕ ..installing java 8, 11, and latest${E}"
brew tap AdoptOpenJDK/openjdk
brew install adoptopenjdk/openjdk/adoptopenjdk8 adoptopenjdk11 adoptopenjdk
for D in /Library/Java/JavaVirtualMachines/* ; do [ -d "${D}" ] && jenv add "${D}/Contents/Home/"; done

# Terminal
printf "${S}📟 Setiing up the terminal${E}"
brew cask install iterm2
printf "\n${Yellow}~~~> 📟 You need to manually install the ${Red}iterm_profile.josn${Yellow} to the iterm2 app${E}"
brew list | grep zsh
if [[ $? == 0 ]] ; then
    printf "${SSP} 📟 ..installing zsh \n"
    printf "some output \n"
    printf "some output \n"
    printf "some output \n"
    brew install zsh
    chsh -s /usr/local/bin/zsh
    printf "${SSP} 📟 ..installing oh-my-zsh \n"
    $ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# update iterm2 settings -> colors, keep directory open new shell, keyboard shortcuts

# Fun tools
brew install fortune
brew install cowsay
# brew install git
# brew install vcprompt
# update bash_profile
# brew cask install spectacle
# brew cask install alfred
# set CMD+space to launch alfred
# brew cask install firefox
# install nvm/node
# curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
# nvm install stable
# mkdir ~/workspace
# npm install -g lite-server eslint
# brew cask install visual-studio-code
# update vscode settings
# install vscode extensions

priintf "\n\n${URed}🎉 Congrats! All done!\n\n${NC}"
