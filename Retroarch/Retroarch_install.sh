#!/bin/bash



:<< "END"

END


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

# Exibe mensagem final
echo "RetroArch compilado e instalado em ~/Apps/Retroarch"
echo "Para rodar: ~/Apps/Retroarch/bin/retroarch"