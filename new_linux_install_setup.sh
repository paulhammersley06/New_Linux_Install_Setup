#! /bin/bash

##If you installed Debian with a root account, you need to log in as root and install Sudo manually
##Also need to manually install git to pull this script

##Set to ask on file override
set -o noclobber

##UserName
echo "Whats you user name?"
read userName

##Add user to sudo group
sudo usermod -aG sudo $userName

WriteToConsole () {
	echo
	echo "------------------------"
	echo "$1"
	echo "------------------------"
	echo
}

WriteToConsole "Installing Curl..."
sudo apt install curl -y

WriteToConsole "Getting repo mirrors..."
sudo apt fetch

##Add the repos
	WriteToConsole "Getting the repo's..."
	##Brave Browser
	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	##GitHub
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
	sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
	##Sublime
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	##VS Codium
	wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg     | gpg --dearmor     | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
	echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main'     | sudo tee /etc/apt/sources.list.d/vscodium.list

	sudo apt update

##Install Gnome (no bloat)
WriteToConsole "Installing KDE (no bloat) and GDM..."
sudo apt install -y kde-plasma-desktop kwin-style-aurorae powerdevil bluedevil kmix gmd3 partitionmanager pipewirepulse plasma-nm --no-install-recommends

##Install file manager
WriteToConsole "Installing Dolphin..."
sudo apt install dolphin

##Install Brave Browser
WriteToConsole "Installing Brave Browser..."
sudo apt install -y brave-browser

##Install GitHub cli
WriteToConsole "Installing GitHub Cli..."
sudo apt install -y gh

##Install Sublime Text
WriteToConsole "Installing Sublime Text..."
sudo apt install -y sublime-text

##Install VS Codium
WriteToConsole "Installing VS Codium..."
sudo apt install -y codium

##Install FastFetch
WriteToConsole "Installing FastFetch..."
sudo apt install -y fastfetch

##Install HTop
WriteToConsole "Installing HTop..."
sudo apt install -y htop

##Install Shotwell (raw image viewer)
WriteToConsole "Installing Shotwell..."
sudo apt install -y shotwell

##Install Jetbrains Toolobox
WriteToConsole "Installing Jetbrains Toolbox..."
cd /home/$userName/Downloads
wget -O JetbrainsToolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.4.1.32573.tar.gz
sudo tar -xvzf JetbrainsToolbox.tar.gz
sudo mv jetbrains-toolbox-2.4.1.32573 /opt/JetbrainsToolbox
cd /opt/JetbrainsToolbox
sudo jetbrains-toolbox

##Enable GUI logon
WriteToConsole "Setting up GUI..."
sudo systemctl enable gdm3 && sudo systemctl set-default graphical.target

##Removing FireFox
sudo apt remove firefox

WriteToConsole "Setup complete. Please reboot"
