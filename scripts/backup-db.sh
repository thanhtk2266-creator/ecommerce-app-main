#!/bin/bash

# Backup database before deployment
BACKUP_DIR="/backups/ecommerce"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
APP_DIR="/home/ec2-user/ecommerce-app"

mkdir -p $BACKUP_DIR

echo "💾 Creating database backup..."
docker exec ecommerce-app-db /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "${DB_SA_PASSWORD}" -Q "BACKUP DATABASE OnlineShopdb TO DISK = '/var/opt/mssql/backup/OnlineShopdb_${TIMESTAMP}.bak'"

echo "✅ Backup completed at $BACKUP_DIR/OnlineShopdb_${TIMESTAMP}.bak"
