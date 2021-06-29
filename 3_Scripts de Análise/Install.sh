#!/usr/bin/bash

echo "Instalando o golang"

apt-get install golang

echo "Entrando na pasta /opt/"


cd /opt/

echo "Instalando o subfinder"

export GOPATH=/opt/subfinder

GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder

ln -s /opt/subfinder/bin/subfinder /usr/local/bin/subfinder

echo "Instalando o assetfinder"

export GOPATH=/opt/assetfinder

go get -u github.com/tomnomnom/assetfinder

ln -s /opt/assetfinder/bin/assetfinder /usr/local/bin/assetfinder


#echo "Instalando o AMASS"

#export GOPATH=/opt/amass

#go get -v github.com/OWASP/Amass/v3/...

#cd /opt/amass/src/github.com/OWASP/Amass

#go install ./..

#cd /opt/

#ln -s /opt/amass/bin/amass /usr/local/bin/amass

echo "Instalando o httprobe"

export GOPATH=/opt/httprobe

go get -u github.com/tomnomnom/httprobe

ln -s /opt/httprobe/bin/httprobe /usr/local/bin/httprobe

echo "Instalando o httpx"

export GOPATH=/opt/httpx

GO111MODULE=on go get -v github.com/projectdiscovery/httpx/cmd/httpx

ln -s /opt/httpx/bin/httpx /usr/local/bin/httpx


echo "Instalando o gorm"
go get -u gorm.io/gorm

echo "Instalando o gowitness"

export GOPATH=/opt/gowitness

go get -u github.com/sensepost/gowitness

ln -s /opt/gowitness/bin/gowitness /usr/local/bin/gowitness


echo "Instalando o nuclei"

export GOPATH=/opt/nuclei

GO111MODULE=on go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei

ln -s /opt/nuclei/bin/nuclei /usr/local/bin/nuclei

echo "Instalando o naabu"

sudo apt install -y libpcap-dev

export GOPATH=/opt/naabu

GO111MODULE=on go get -v github.com/projectdiscovery/naabu/v2/cmd/naabu

ln -s /opt/naabu/bin/naabu /usr/local/bin/naabu

echo "Script Finalizado"
