#! /bin/bash

##Set to ask on file override
set -o noclobber

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
	sudo apt update && apt install -y brave-browser
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
	WriteToConsole "Git installed successfully"

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
	echo "Do you want Nala to find the best image sites [y|n]?"
	read isFindImage
	if [[ $isFindImage == y ]]; then
		sudo nala fetch	
	fi
	
	##Substitutes apt to nala
	echo "Do you want Nala to replace apt [y|n]?"
	read isReplaceApt
	if [[ $isReplaceApt == y ]]; then
		##Backing up .bashrc first
		sudo cp /home/paul/.bashrc /home/paul/.bashrc_backup
		sudo cat nala_config.txt >> /home/paul/.bashrc
	fi
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
	echo "Do you want docker to load at system startup [y|n]?"
	read isDockerLoad
	if [[ $isDockerLoad == y ]]; then
		sudo systemctl enable docker.service && sudo systemctl enable containerd.service	
	fi
	##Do we want a container setting up now?
	echo "Do you want to create a postgres docker container now [y|n]?"
	read isDockerContainer
	echo $isDockerContainer
	if [[ $isDockerContainer == y ]]; then
		echo "What's your postgres user name?"
		read pgUser
		echo "What's your postgres password?"
		read pgPass
		echo "What do you want your container to be called?"
		read containerName
		echo "What do you want your database to be called?"
		read dbName
		sudo docker run --name $containerName -e POSTGRES_USER=$pgUser -e POSTGRES_PASSWORD=$pgPass -e POSTGRES_DB=$dbName library/postgres
	fi
	WriteToConsole "Docker successfully installed"

##Install Jetbrains stuff
	##Install DataGrip
	WriteToConsole "Installing DataGrip..."
	cd /home/paul/Downloads
	wget -O DataGrip.tar.gz https://www.jetbrains.com/datagrip/download/
	sudo tar -xf DataGrip.tar.gz -C /opt/
	WriteToConsole "DataGrip successfully installed"

	##Install Rider
	WriteToConsole "Installing Rider..."
	cd /home/paul/Downloads
	wget -O Rider.tar.gz https://www.jetbrains.com/rider/download/	
	sudo tar -xf Rider.tar.gz -C /opt/
	WriteToConsole "Rider successfully installed"