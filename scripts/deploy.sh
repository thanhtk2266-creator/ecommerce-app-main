#!/bin/bash

# Simple deployment script to pull and restart services
set -e

APP_DIR="/home/ec2-user/ecommerce-app"
cd $APP_DIR

echo "🔄 Pulling latest code..."
git fetch origin main
git reset --hard origin/main

echo "📦 Pulling latest Docker images..."
docker-compose pull

echo "🚀 Starting containers..."
docker-compose up -d

echo "✅ Deployment completed"
echo "📊 Status:"
docker-compose ps

echo ""
echo "📋 Recent logs (last 50 lines):"
docker-compose logs --tail=50 backend frontend
