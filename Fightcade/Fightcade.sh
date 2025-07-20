#!/bin/bash

# Ir para a pasta Documents
cd ~/Documents || exit

# Baixar o instalador do Fightcade
wget -O fightcade.tar.gz https://www.fightcade.com/download/linux

# Criar pasta Fightcade e extrair
tar -xzf fightcade.tar.gz

# Baixar o fc2json.zip
wget -O fc2json.zip https://fightcade.download/fc2json.zip

# Extrair para a pasta de emuladores dentro do Fightcade
unzip -o fc2json.zip -d /home/pinguim/Documents/Fightcade/emulator/

# Remover os arquivos baixados
rm fightcade.tar.gz fc2json.zip

chmod -R 777 /home/pinguim/Documents/Fightcade

echo"#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Exec=/home/pinguim/Documents/Fightcade/Fightcade2.sh
Name=Fightcade
Comment=Fightcade
Categories=Game;Emulator;ArcadeGame
Icon=/home/pinguim/Documents/Fightcade/fc2-electron/resources/app/icon.png
" > /home/pinguim/Documents/Fightcade/Fightcade.desktop

echo "Instalação concluída com sucesso!"
