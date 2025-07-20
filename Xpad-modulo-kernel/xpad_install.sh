#!/bin/bash

# Script para instalar o driver aprimorado do xpad no Linux
# Autor: Jeverson (ajuste conforme desejar)
# Data: 2025-07-18

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
