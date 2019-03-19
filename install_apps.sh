#! /usr/bin/env bash

# Installs Homebrew software.

if ! command -v brew > /dev/null; then
    ruby -e "$(curl --location --fail --show-error https://raw.githubusercontent.com/Homebrew/install/master/install)"
    export PATH="/usr/local/bin:$PATH"
    printf "export PATH=\"/usr/local/bin:$PATH\"\n" >> $HOME/.bash_profile
fi

printf "Updating brew\n"
brew upgrade && brew update

printf "Installing xcode cli utils\n"
xcode-select --install

printf "brew: Installing cli packages\n"
brew install git
brew install gpg
brew install mas            # Apple store cli
brew install node           # NodeJS dev
brew install openssl        # Generate certificates
brew install ruby-install 
brew install terraform      # Automation
brew install vim            # Guilty pleasure
brew install watch
brew install wakeonlan      
brew install wget

# Install ZSH and Oh My ZSH
brew install zsh zsh-completions zsh-autosuggestions zsh-syntax-highlighting 

chsh -s /usr/local/bin/zsh
/usr/local/bin/zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


printf "brew: Installing apps\n"
brew cask install 1password
brew cask install 1password-cli
brew cask install bartender
brew cask install dropbox
brew cask install docker
brew cask install evernote
brew cask install firefox
brew cask install franz
brew cask install google-chrome
brew cask install grammarly
brew cask install handbrake
brew cask install istat-menus
brew cask install iterm2
brew cask install java
brew cask install keybase
brew cask install ngrok
brew cask install nordvpn
brew cask install postman
brew cask install powershell
brew cask install slack
brew cask install spotify
brew cask install tor-browser
brew cask install tuxera-ntfs
brew cask install rescuetime
brew cask install royal-tsx
brew cask install visual-studio-code
brew cask install vlc
brew cask install vmware-fusion
brew cask install wireshark
brew cask install wifi-explorer
brew cask install zoomus
brew cask install zoomus-outlook-plugin
brew cask install xmind-zen


# Installs App Store software.

if ! command -v mas > /dev/null; then
  printf "ERROR: Mac App Store CLI (mas) can't be found.\n"
  printf "       Please ensure Homebrew and mas (i.e. brew install mas) have been installed first."
  exit 1
fi

printf "AppStore: Installing The Unarchiver\n"
mas install 425424353  

printf "AppStore: Installing Todoist\n"
mas install 585829637  

printf "AppStore: Installing Tweetbot 3\n"
mas install 1384080005

printf "AppStore: Installing Microsoft Remote Desktop 10\n"
mas install 1295203466  

printf "AppStore: Installing Microsoft OneDrive\n"
mas install 823766827 

printf "AppStore: Installing Microsoft OneNote\n"
mas install 784801555 

printf "AppStore: Installing Microsoft Excel\n"
mas install 462058435 

printf "AppStore: Installing Microsoft Outlook\n"
mas install 985367838 

printf "AppStore: Installing Microsoft Word\n"
mas install 462054704

printf "AppStore: Installing Microsoft PowerPoint\n"
mas install 462062816 

printf "Installing offline apps..\n"
for f in offline-apps/*.pkg ; 
  do sudo installer -pkg "$f" -target /
done

printf "Downloading and installing apps via .dmg links..\n"
URLs=(
  https://download.techsmith.com/camtasiamac/releases/Camtasia.dmg
  https://download.techsmith.com/snagitmac/releases/Snagit.dmg
  https://download01.logi.com/web/ftp/pub/techsupport/presentation/LogiPresentation_1.52.95.dmg
  https://jabraxpressonlineprdstor.blob.core.windows.net/jdo/JabraDirectSetup.dmg
  http://files.whatpulse.org/whatpulse-mac-2.8.4.dmg
)

for i in "${URLs[@]}"; 
do
  wget -P ~/Downloads/ "$i"
  DMG=$(echo $i | rev | cut -d / -f 1 | rev)
  VOL=$(hdiutil attach ~/Downloads/$DMG | grep -i '/Volumes/' | awk -F " " '{print $3}')

  if [ -e "$VOL"/*.app ]; then
    sudo cp -rf "$VOL"/*.app /Applications/
  elif [ -e "$VOL"/*.pkg ]; then
    package=$(ls -1 "$VOL" | grep .pkg | head -1)
    sudo installer -pkg "$VOL"/"$package" -target /
  elif [ -e "$VOL"/*.mpkg ]; then
    package=$(ls -1 "$VOL" | grep .mpkg | head -1)
    sudo installer -pkg "$VOL"/"$package" -target /
  fi

  hdiutil unmount "$VOL"
done
