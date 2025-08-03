#!/bin/bash

echo "🔧 Configurando Git..."
if [ -f "setup-git.sh" ]; then
  chmod +x setup-git.sh
  ./setup-git.sh
fi


echo "🔧 Configurando permissões..."
sudo chown -R node:node /usr/src/app

echo "📦 Verificando dependências..."
if [ ! -d "node_modules" ] || [ -z "$(ls -A node_modules)" ]; then
  echo "📦 Instalando dependências..."
  npm install
else
  echo "✅ Dependências já instaladas."
fi

echo "🧹 Limpando cache de build..."
rm -rf dist

echo "🔨 Compilando TypeScript..."
npm run build

echo "🚀 Iniciando em modo desenvolvimento (hot reload)..."
npm run start:dev