#!/bin/bash
# Curitiba 20 de Julho de 2025.
# Editor: Jeverson D. Silva   ///@JCGAMESCLASSICOS...

# Repositório para as instalações iniciais do sistema Linux MiniOS.

# Módulo xpad
# Script para instalar o driver aprimorado do xpad no Linux

set -e  # Faz o script parar em caso de erro

echo "==> Atualizando o sistema..."
sudo apt update && sudo apt upgrade -y

echo "==> Instalando dependências necessárias..."
sudo apt install -y git build-essential dkms linux-headers-$(uname -r)

echo "==> Clonando repositório do xpad melhorado..."
git clone https://github.com/paroj/xpad.git ~/Documents/xpad
cd ~/Documents/xpad

echo "==> Removendo o módulo xpad padrão, se existir..."
sudo rmmod xpad || echo "Módulo xpad não estava carregado."

echo "==> Compilando o driver xpad..."
make

echo "==> Instalando o novo módulo..."
sudo mkdir -p /lib/modules/$(uname -r)/kernel/drivers/hid/xpad/
sudo cp xpad.ko /lib/modules/$(uname -r)/kernel/drivers/hid/xpad/
sudo depmod -a
sudo modprobe xpad

echo "==> Configurando para carregar o módulo no boot..."
echo "xpad" | sudo tee /etc/modules-load.d/xpad.conf

echo "✅ Instalação concluída com sucesso!"



# retroarch

sudo apt install -y git build-essential libudev-dev libx11-dev libgl1-mesa-dev \
libasound2-dev libpulse-dev libv4l-dev libxi-dev libxext-dev libxinerama-dev \
libxrandr-dev libxcursor-dev libxkbcommon-dev libwayland-dev libdrm-dev \
libsdl2-dev libfreetype6-dev libavcodec-dev libavformat-dev libavutil-dev \
libswscale-dev libssl-dev pkg-config zlib1g-dev libx11-xcb-dev 




# Atualiza a lista de pacotes
sudo apt update

# Instala dependências necessárias para compilar (adapte se quiser adicionar mais libs)
sudo apt install -y build-essential pkg-config libx11-xcb-dev

# Clona o repositório do RetroArch (se ainda não clonou)
git clone https://github.com/libretro/RetroArch.git ~/Documents/RetroArch

# Entra na pasta do código fonte
cd ~/Documents/RetroArch

# Executa o script de configuração definindo o prefixo para instalação local
./configure  #--prefix=$HOME/Apps/Retroarch

# Compila o projeto
make -j$(nproc)

# Instala o binário e arquivos na pasta desejada
sudo make install



# wine

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
