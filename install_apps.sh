#! /usr/bin/env bash

# Installs Homebrew software.

if ! command -v brew > /dev/null; then
    ruby -e "$(curl --location --fail --show-error https://raw.githubusercontent.com/Homebrew/install/master/install)"
    export PATH="/usr/local/bin:$PATH"
    printf "export PATH=\"/usr/local/bin:$PATH\"\n" >> $HOME/.bash_profile
fi

printf "Updating brew\n"
brew upgrade && brew update

brew install mas            # Apple store cli

printf "AppStore: Installing Xcode\n"
mas install 497799835

printf "Installing xcode cli utils\n"
xcode-select --install

printf "brew: Installing cli packages\n"
brew install git
brew install gpg
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


brew install romkatv/powerlevel10k/powerlevel10k
echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
sudo cp *.ttf /Library/Fonts/


printf "brew: Installing apps\n"
brew cask install 1password
brew cask install 1password-cli
brew install --cask adguard
brew install --cask alfred
brew cask install bartender
brew install --cask brave-browser
brew install --cask camtasia
brew install --cask cyberduck
brew cask install dropbox
brew install --cask discord
brew cask install docker
brew cask install evernote
brew cask install firefox
brew install flux
brew cask install franz
brew install --cask gimp
brew cask install google-chrome
brew cask install grammarly
brew cask install handbrake
brew cask install istat-menus
brew cask install iterm2
brew cask install java
brew cask install keybase
brew cask install ngrok
brew cask install nordvpn
brew install --cask notion
brew install --cask packages
brew cask install postman
brew cask install powershell
brew cask install slack
brew install --cask snagit
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

printf "AppStore: Installing Magnet\n"
mas install 441258766

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
  http://files.whatpulse.org/whatpulse-mac-3.1.dmg
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
