#!/bin/bash

# Mover o mouse para o centro da tela (1920x1080)
xdotool mousemove 960 540
sleep 0.1

# Clique esquerdo (foca ou seleciona item)
xdotool click 1
sleep 0.15

# Simula Ctrl+L (ativa barra de endereço) e Ctrl+C (copia caminho)
xdotool key ctrl+l
sleep 0.1
xdotool key ctrl+c
sleep 0.1

# Captura da área de transferência
caminho=$(xclip -o -selection clipboard)

# Limpa a área de transferência imediatamente
echo -n "" | xclip -selection clipboard

# Se não capturou nada, usa ~/Desktop como fallback
if [ -z "$caminho" ]; then
  caminho="$HOME/Desktop"
  echo "Nenhum caminho detectado no Thunar. Usando fallback: $caminho"
else
  echo "Diretório atual no Thunar: $caminho"
fi

# Abre o terminal no diretório final
if [ -d "$caminho" ]; then
  xfce4-terminal --maximize --working-directory="$caminho"
else
  echo "Erro: Diretório inválido: $caminho"
fi