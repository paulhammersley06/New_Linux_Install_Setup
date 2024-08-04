#! /bin/bash

##If you installed Debian with a root account, you need to log in as root and install Sudo manually
##Also need to manually install git to pull this script
##Fav theme at the mo - WhiteSur - Dark Nord and Nordzy icon pack

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

##Install Nala
WriteToConsole "Installing Nala..."
sudo apt install -y nala

WriteToConsole "Getting repo mirrors..."
sudo nala fetch

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
	wget https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list > dev/null

	sudo apt-get update -y

##Install Gnome (no bloat)
WriteToConsole "Installing Gnome (no bloat)..."
sudo nala install -y gdm3 gnome-shell gnome-terminal gnome-tweaks

##Install file manager
WriteToConsole "Installing Nemo..."
sudo nala install nemo

##Install Brave Browser
WriteToConsole "Installing Brave Browser..."
sudo nala install -y brave-browser

##Install GitHub cli
WriteToConsole "Installing GitHub Cli..."
sudo nala install -y gh

##Install Sublime Text
WriteToConsole "Installing Sublime Text..."
sudo nala install -y sublime-text

##Install NeoFetch
WriteToConsole "Installing NeoFetch..."
sudo nala install -y neofetch

##Install HTop
WriteToConsole "Installing HTop..."
sudo nala install -y htop

##Install Shotwell (raw image viewer)
WriteToConsole "Installing Shotwell..."
sudo nala install -y shotwell

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

##Substitutes apt to nala
echo "Do you want Nala to replace apt [y|n]?"
read isReplaceApt
if [[ $isReplaceApt == y ]]; then
	##Backing up .bashrc first
	cp /home/$userName/.bashrc /home/$userName/.bashrc_backup
	cat nala_config.txt >> /home/$userName/.bashrc
fi

WriteToConsole "Setup complete. Please reboot"