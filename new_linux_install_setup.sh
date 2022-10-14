#! /bin/bash

WriteToConsole () {
	echo
	echo "------------------------"
	echo "$1"
	echo "------------------------"
	echo
}

##Install Brave Browser
	WriteToConsole "Installing Brave Browser..."
	##Get the stuff and add the repo
	sudo apt install apt-transport-https curl
	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	##Install brave
	sudo apt update && apt install brave-browser
	WriteToConsole "Brave Browser successfully installed"

##Install .Net 6
	WriteToConsole "Installing .Net 6 SDK..."
	##Get the stuff and add .net6 SDK repo
	wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
	sudo dpkg -i packages-microsoft-prod.deb
	rm packages-microsoft-prod.deb
	##Install .net sdk
	sudo apt-get update && sudo apt-get install -y dotnet-sdk-6.0
	WriteToConsole ".Net 6 SDK successfully installed"

##Install Git
	WriteToConsole "Installing Git..."
	sudo apt install git
	WriteToConsole "Git installe successfully"

##Install GitHub cli
	WriteToConsole "Installing GitHub Cli..."
	##Get the stuff and add github cli repo
	type -p curl >/dev/null || sudo apt install curl -y
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
	sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
	##Install github cli
	sudo apt update	&& sudo apt install gh -y
	WriteToConsole "GitHub Cli successfully installed"

##Install Nala
	WriteToConsole "Installing Nala..."
	##Get the stuff and add the repo
	echo "deb http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list; 
	wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg
	##Install Nala
	sudo apt update && sudo apt install nala
	##Gets best image site
	sudo nala fetch
	##Points apt to nala
	##Add this to  ~/.bashrc AND /root/.bashrc files to substitute apt for Nala:
	##apt() { 
	##  command nala "$@"
	##}
	##sudo() {
	##  if [ "$1" = "apt" ]; then
	##    shift
	##    command sudo nala "$@"
	##  else
	##    command sudo "$@"
	##  fi
	##}
	WriteToConsole "Nala successfully installed"

##Install Sublime Text
	WriteToConsole "Installing Sublime Text..."
	##Get the stuff and add the repo
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	##Install Sublime Text
	sudo apt update && sudo apt install sublime-text
	WriteToConsole "Sublime Text successfully installed"

##Install docker
	WriteToConsole "Installing Docker..."
	##Get the stuff and add the repo
	sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian buster stable" | sudo tee /etc/apt/sources.list.d/docker.list
	##Install Docker
	sudo apt update && sudo apt install docker-ce docker-ce-cli containerd.io
	##Do we want docker to start at sytem load?
	#sudo systemctl enable docker.service && sudo systemctl enable containerd.service
	##Do we want a container setting up now?
	#sudo docker run -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=blog_user -e POSTGRES_DB=blog_db library/postgres
	WriteToConsole "Docker successfully installed"

##Install Jetbrains stuff
	##Install DataGrip
	##wget https://www.jetbrains.com/datagrip/download/
	##cd into directory
	##sudo tar xzf datagrip-*.tar.gz -C /opt/

	##Install Rider
	##wget https://www.jetbrains.com/rider/download/
	##cd into directory
	##sudo tar xzf datagrip-*.tar.gz -C /opt/