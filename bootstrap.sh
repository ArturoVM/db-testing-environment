which docker &>/dev/null
if [ $? -eq 1  ]; then
	sudo apt-get update
	sudo apt-get install -y htop vim screen tmux wget curl
	sudo wget -qO- https://get.docker.com/ | sh
	sudo usermod -a -G docker vagrant
fi

(cd /vagrant && sudo make run)
