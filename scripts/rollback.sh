#!/bin/bash

# Rollback to previous version
APP_DIR="/home/ec2-user/ecommerce-app"
cd $APP_DIR

echo "⚠️ Rolling back to previous version..."

# Show commit history
echo "Last 5 commits:"
git log --oneline -5

read -p "Enter commit hash to rollback to: " COMMIT_HASH

git reset --hard $COMMIT_HASH

docker-compose pull
docker-compose up -d

echo "✅ Rollback completed"
docker-compose ps
