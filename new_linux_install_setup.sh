#! /bin/bash

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

##Install Gnome (no bloat)
WriteToConsole "Installing Gnome (no bloat)..."
sudo apt-get install -y gdm3

##Install Dependencies
WriteToConsole "Installing dependencies..."
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common

##Add the repos
	WriteToConsole "Getting the repo's..."
	##Brave Browser
	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	##.Net 6
	wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
	sudo dpkg -i packages-microsoft-prod.deb
	rm packages-microsoft-prod.deb
	##GitHub
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
	sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
	##Nala
	echo "deb http://deb.volian.org/volian/ scar main" | sudo gpg --dearmor | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
	wget https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > dev/null
	##Sublime
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	wget https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
	##Docker
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian buster stable" | sudo tee /etc/apt/sources.list.d/docker.list

	sudo apt-get update -y


##Install Brave Browser
	WriteToConsole "Installing Brave Browser..."
	##Install brave
	sudo apt install -y brave-browser

##Install .Net 6
	WriteToConsole "Installing .Net 6 SDK..."
	##Install .net sdk
	sudo apt-get install -y dotnet-sdk-6.0

##Install Git
	WriteToConsole "Installing Git..."
	sudo apt install -y git

##Install GitHub cli
	WriteToConsole "Installing GitHub Cli..."	
	##Install github cli
	sudo apt install -y gh

##Install Starship (terminal customisation from Chris Titus)
	WriteToConsole "Installing Starship..."
	mkdir GitHub
	cd GitHub
	git clone https://github.com/christitustech/mybash
	cd mybash
	sudo bash setup.sh

##Install Nala
	WriteToConsole "Installing Nala..."	
	##Install Nala
	sudo apt install -y nala

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
		cp /home/$userName/.bashrc /home/$userName/.bashrc_backup
		cat nala_config.txt >> /home/$userName/.bashrc
	fi

##Install Sublime Text
	WriteToConsole "Installing Sublime Text..."
	##Install Sublime Text
	sudo apt-get install -y sublime-text

##Install NeoFetch
	WriteToConsole "Installing NeoFetch..."
	sudo apt install -y neofetch

##Install HTop
	WriteToConsole "Installing HTop..."
	sudo apt install -y htop

##Install docker
	WriteToConsole "Installing Docker..."
	##Install Docker
	sudo apt install -y docker-ce docker-ce-cli containerd.io
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

##Install Jetbrains stuff
	##Install DataGrip
	WriteToConsole "Installing DataGrip..."
	cd /home/$userName/Downloads
	wget -O DataGrip.tar.gz https://download.jetbrains.com/datagrip/datagrip-2022.2.5.tar.gz
	sudo tar -xf DataGrip.tar.gz -C /opt/

	##Install Rider
	WriteToConsole "Installing Rider..."
	cd /home/$userName/Downloads
	wget -O Rider.tar.gz https://download.jetbrains.com/rider/JetBrains.Rider-2022.2.3.tar.gz
	sudo tar -xf Rider.tar.gz -C /opt/

WriteToConsole "Setup complete. Please Reboot"