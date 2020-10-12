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
# Functions
function brew_install ()
{
    search_result=$(brew list | grep -m 1 "$1")
    installing=0
    if [ -z $search_result ]
    then
      printf "\n${UGreen} >> ...installing $1 ${E}"
      brew install $1
      installing=1
    fi

    printf "\n${UGreen}✅ $1 Successfully installed${E}"
    return $installing
}

function brew_cask_install ()
{
    search_result=$(brew list --cask | grep -m 1 "$1")
    installing=0
    if [ -z $search_result ]
    then
      printf "\n${UGreen} >> ...installing $1 ${E}"
      #brew cask install $1
      installing=1
    fi

    printf "\n${UGreen}✅ $1 Successfully installed${E}"
    return $installing
}

# -----------------------------------------------------------------------------
# Begginning of script
clear
printf "\n${UGreen}👋 Hi there! let's prepare this machine for a development!${E}"
printf "${S}🍏 Let's start with a xcode dev tools. Installing..${E}"

# -----------------------------------------------------------------------------
# xCode tools & osx software updates
xcode-select --install
R=$(SoftwareUpdate -l | grep -m 1 "Software Update found")
if [ ! -z $R ]
then
  printf "${SSP} 🍏 ..installing osx software updates \n"
  SoftwareUpdate -l -i -a
  TODOS+="${MAN} 💻 You shall ${Red}restart your mac${Yellow} to finish osx Software Update process${E}"
fi

# -----------------------------------------------------------------------------
# Create dev directory
cd ~
if [ ! -d "dev" ] ; then
  printf "${S}📂 Directory ~/dev does not exists. Creating..${E}"
  mkdir dev
fi

# -----------------------------------------------------------------------------
# Homebrew
R=$(which brew)
if [ -z $R ]
then
  printf "${S}🍺 Homebrew is not installed. Installing Homebrew${E}"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew update
brew upgrade

# -----------------------------------------------------------------------------
# Java
printf "${S}☕ Installing java and jenv${E}"
printf "${SSP} ☕ ..installing jenv${E}"


brew_install "jenv"
if [ $? == 1 ]
then
  unset JAVA_TOOL_OPTIONS
  printf "${SSP} ☕ ..installing java 8, 11, and latest${E}"
  brew tap AdoptOpenJDK/openjdk
  brew_cask_install "adoptopenjdk/openjdk/adoptopenjdk8"
  brew_cask_install "adoptopenjdk11"
  brew cask install "adoptopenjdk"
  for D in /Library/Java/JavaVirtualMachines/* ; do [ -d "${D}" ] && jenv add "${D}/Contents/Home/"; done
fi
eval "$(jenv init -)"
jenv enable-plugin gradle
jenv enable-plugin export

# -----------------------------------------------------------------------------
# Terminal
printf "${S}📟 Setiing up the terminal${E}"
brew_cask_install "iterm2"
TODOS+="${MAN} 📟 You need to manually install the ${Red}iterm_profile.json${Yellow} to the iterm2 app${E}"

brew_install "zsh"
if [ $? == 1 ]
then
  chsh -s /usr/local/bin/zsh
  printf "${SSP} 📟 ..installing oh-my-zsh \n"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
cp .zshrc ~/.zshrc


# -----------------------------------------------------------------------------
# VSCode
brew_cask_install "visual-studio-code"
# update vscode settings
# install vscode extensions

# -----------------------------------------------------------------------------
# Setup android sdk
TODOS+="${MAN} 🤖 Please use ${Red} $ANDROID_HOME ${Yellow} directory in android sdk installation${E}"
# >> install deep clean
brew install kotlin maven holgerbrandl/tap/kscript
R=$(ls -la ~/div | grep -m 1 "deep-clean.kts")
if [ ! -z $R ]
then
  rm ~/dev/deep-clean.kts
fi
curl -fsSL https://raw.githubusercontent.com/rock3r/deep-clean/master/deep-clean.kts -o ~/dev/deep-clean.kts

# -----------------------------------------------------------------------------
# Install Apps
brew_cask_install "google-chrome"
brew_cask_install "jetbrains-toolbox"
brew_cask_install "adguard"

# -----------------------------------------------------------------------------
# Fun tools
brew_install fortune
brew_install cowsay

# -----------------------------------------------------------------------------
# Finish setup
printf "\n${UYellow}Please check out notes marked with a ⭕ listed below."
printf "\nYou might need to do them manually for a complete setup!${E}"
printf "\n${TODOS} \n\n"

echo  "🎉${Red}Congrats! All done!${NC} 🎉/"
source ~/.zshrc
