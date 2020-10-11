#!/bin/bash

# -----------------------------------------------------------------------------
# Constants
Red='\033[0;31m'          # Red
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Green='\033[0;32m'        # Green
Cyan='\033[0;36m'         # Cyan

URed='\033[4;31m'         # Red
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UGreen='\033[4;32m'       # Green
NC='\033[0m'       # Text Reset

S="\n${UBlue}"
E="${NC}\n"
SSP="\n${Cyan}~~~>"
MAN="\n ⭕ ${Yellow}~~~>"
TODOS=""

# -----------------------------------------------------------------------------
# Begginning of script
clear
printf "\n${UGreen}👋 Hi there! let's prepare this machine for a development!${E}"
printf "${S}🍏 Let's start with a xcode dev tools. Installing..${E}"

# -----------------------------------------------------------------------------
# xCode tools & osx software updates
xcode-select --install
SoftwareUpdate -l | grep "Software Update found"
if [[ $? != 0 ]] ; then
  printf "${SSP} 🍏 ..installing osx software updates \n"
  SoftwareUpdate -l -i -a
  TODOS+="${MAN} 📟 ⭕ You shall ${Red}restart your mac${Yellow} to finish osx Software Update process${E}"
fi

# -----------------------------------------------------------------------------
# dev directory
cd ~
if [ ! -d "dev" ] ; then
  printf "${S}📂 Directory ~/dev does not exists. Creating..${E}"
  mkdir dev
fi

# -----------------------------------------------------------------------------
# Homebrew
which -s brew
if [[ $? != 0 ]] ; then
  printf "${S}🍺 Homebrew is not installed. Installing Homebrew${E}"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew update

# -----------------------------------------------------------------------------
# Java
printf "${S}☕ Installing java and jenv${E}"
printf "${SSP} ☕ ..installing jenv${E}"
brew install jenv
unset JAVA_TOOL_OPTIONS
printf "${SSP} ☕ ..installing java 8, 11, and latest${E}"
brew tap AdoptOpenJDK/openjdk
brew install adoptopenjdk/openjdk/adoptopenjdk8 adoptopenjdk11 adoptopenjdk
for D in /Library/Java/JavaVirtualMachines/* ; do [ -d "${D}" ] && jenv add "${D}/Contents/Home/"; done
jenv enable-plugin gradle
jenv enable-plugin export


# -----------------------------------------------------------------------------
# Terminal
printf "${S}📟 Setiing up the terminal${E}"
brew cask install iterm2
TODOS+="${MAN} 📟 ⭕ You need to manually install the ${Red}iterm_profile.json${Yellow} to the iterm2 app${E}"
brew list | grep zsh
if [[ $? == 0 ]] ; then
  printf "${SSP} 📟 ..installing zsh \n"
  brew install zsh
  chsh -s /usr/local/bin/zsh
  printf "${SSP} 📟 ..installing oh-my-zsh \n"
  $ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
cp ./zshrc ~/.zshrc

# -----------------------------------------------------------------------------
# VSCode
ls /Applications | grep "VSCode"
if [[ $? == 0 ]] ; then
  brew cask install visual-studio-code
  curl -fsSL https://raw.githubusercontent.com/rock3r/deep-clean/master/deep-clean.kts -o ~/dev/deep-clean.kts
fi

# update vscode settings
# install vscode extensions

# -----------------------------------------------------------------------------
# Setup android sdk

# -----------------------------------------------------------------------------
# Install deep clean
brew install kotlin maven holgerbrandl/tap/kscript

# -----------------------------------------------------------------------------
# Setup Google chrome
ls /Applications | grep "Google Chrome"
if [[ $? == 0 ]] ; then
  brew cask install google-chrome
fi

# -----------------------------------------------------------------------------
# Fun tools
brew install fortune
brew install cowsay

# -----------------------------------------------------------------------------
# Finish setup
if [[ $TODOS != 0 ]] ; then
  printf "\n${UYellow}Please check out notes marked with a ⭕ listed below.
          \nThey are needed to be done manually for a complete setup!${E}"
  printf "\n${TODOS} \n\n"
fi

echo  "🎉 Congrats! All done! 🎉" | cowsay -f tux
