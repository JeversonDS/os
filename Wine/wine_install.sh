#!/bin/bash
set -e

echo "Habilitando arquitetura i386 para suporte a 32 bits..."
sudo dpkg --add-architecture i386

echo "Atualizando lista de pacotes..."
sudo apt update

echo "Instalando dependências básicas..."
sudo apt install -y software-properties-common wget apt-transport-https gnupg2

echo "Adicionando chave do WineHQ..."
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key

echo "Adicionando repositório do WineHQ para Debian bookworm..."
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/debian/ bookworm main'

echo "Atualizando novamente a lista de pacotes..."
sudo apt update

echo "Instalando Wine (versão estável)..."
sudo apt install -y --install-recommends winehq-stable

echo "Verificando versão do Wine instalada:"
wine --version