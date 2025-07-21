# Fightcade
echo "Instalando Fightcade..."

# Ir para a pasta pessoal do usuário
cd "$HOME/Documents" || exit

# Baixar o Fightcade
wget -O fightcade.tar.gz https://www.fightcade.com/download/linux

# Extrair o Fightcade
tar -xzf fightcade.tar.gz

# Baixar o fc2json.zip
wget -O fc2json.zip https://fightcade.download/fc2json.zip

# Criar pasta de emuladores (caso não exista)
mkdir -p "$HOME/Documents/Fightcade/emulator"

# Extrair fc2json.zip na pasta correta
unzip -o fc2json.zip -d "$HOME/Documents/Fightcade/emulator/"

# Remover os arquivos baixados
rm fightcade.tar.gz fc2json.zip

# Dar permissões necessárias
chmod -R 755 "$HOME/Documents/Fightcade"

# Criar atalho .desktop
mkdir -p "$HOME/.local/share/applications"

cat <<EOF > "$HOME/.local/share/applications/Fightcade.desktop"
[Desktop Entry]
Version=1.0
Type=Application
Name=Fightcade
Comment=Fightcade client for online retro gaming
Exec=$HOME/Documents/Fightcade/Fightcade2.sh
Icon=$HOME/Documents/Fightcade/fc2-electron/resources/app/icon.png
Terminal=false
Categories=Game;Emulator;ArcadeGame;
EOF

# Tornar o atalho executável
chmod +x "$HOME/.local/share/applications/Fightcade.desktop"

echo "Fightcade instalado com sucesso!"
