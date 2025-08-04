#!/bin/bash

#Criando .env a partir do .env.example
if [ ! -f .env ]; then
  echo "Criando arquivo .env a partir do .env.example..."
  cp .env.example .env
  echo "Arquivo .env criado com sucesso!"
else
  echo "Arquivo .env já existe. Usando o existente."
fi

source .env

HOST=${HOST:-localhost}
API_PORT=${API_PORT:-3000}
ORDER_SERVICE_PORT=${ORDER_SERVICE_PORT:-3001}
PAYMENT_SERVICE_PORT=${PAYMENT_SERVICE_PORT:-3002}
NOTIFICATION_SERVICE_PORT=${NOTIFICATION_SERVICE_PORT:-3003}

echo "🚀 Iniciando microsserviços..."

# Configurar submodules
echo "📦 Configurando submodules..."
git submodule init
git submodule update

# Criar rede Docker
echo "🌐 Criando rede Docker..."
docker network create microservices_network-adson || echo "Rede já existe."

# Subir containers
echo "🐳 Subindo containers..."
docker compose up -d --build

echo "✅ Ambiente pronto!"
echo ""
echo "📋 API:  http://${HOST}:${API_PORT}"
echo ""
echo "📋 Serviços:"
echo "  • Order Service: http://${HOST}:${ORDER_SERVICE_PORT}"
echo "  • Payment Service: http://${HOST}:${PAYMENT_SERVICE_PORT}"
echo "  • Notification Service: http://${HOST}:${NOTIFICATION_SERVICE_PORT}"
echo ""
echo "💡 Ver logs: docker-compose logs -f"