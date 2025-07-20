#!/bin/bash

if [ -z "$1" ]; then
  echo "Uso: $0 <diretório>"
  exit 1
fi

# Caminho absoluto do diretório passado
absoluto=$(readlink -f "$1")

# Procura o arquivo autorun.cmd dentro do diretório e subpastas
local=$(find "$absoluto" -name autorun.cmd -print -quit)

if [ -z "$local" ]; then
  echo "Arquivo autorun.cmd não encontrado em $absoluto"
  exit 1
fi

echo "Arquivo encontrado em: $local"

# Converte para formato Unix (remove CR \r)
dos2unix "$local" >/dev/null 2>&1

dir=""
cmd=""

# Leitura do autorun.cmd, considerando linha final sem quebra de linha
while IFS='=' read -r key value || [ -n "$key" ]; do
  # Debug (pode comentar depois)
  echo "Linha lida: key='$key' | value='$value'"

  [[ -z "$key" || -z "$value" ]] && continue
  [[ "$key" =~ ^# ]] && continue

  key=$(echo "$key" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  value=$(echo "$value" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  value=$(echo "$value" | sed 's/^"//;s/"$//')

  echo "Trim e sem aspas: key='$key' | value='$value'"

  case "$key" in
    DIR) dir="$value" ;;
    CMD) cmd="$value" ;;
  esac
done < "$local"

echo
echo "Valores extraídos:"
echo "DIR = $dir"
echo "CMD = $cmd"
echo

# Caminho para rodar o comando
run_path="$absoluto/$dir"

if [ ! -d "$run_path" ]; then
  echo "Erro: diretório para rodar o comando não existe: $run_path"
  exit 1
fi

if [ -z "$cmd" ]; then
  echo "Erro: comando CMD vazio."
  exit 1
fi

echo "Executando comando na pasta: $run_path"
echo "Comando: $cmd"

cd "$run_path" || { echo "Falha ao entrar no diretório $run_path"; exit 1; }

# Exemplo: rodar com wine (ajuste conforme seu caso)
wine "$cmd"