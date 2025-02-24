#!/bin/bash

# Configuração
DB_HOST=${DB_HOST:-"ip/host"}
DB_PORT=${DB_PORT:-"porto"}
DB_USER=${DB_USER:-"user"}
DB_PASSWORD=${DB_PASSWORD:-"password"}
DB_NAME=${DB_NAME:-"nome_da_db"}
BACKUP_DIR=${BACKUP_DIR:-"/mnt/backups"}
RETENTION_DAYS=${RETENTION_DAYS:-X}
ENCRYPTION_KEY=${ENCRYPTION_KEY:-"minha_chave_secreta"}

# Data e hora
TIMESTAMP=$(date "+%Y-%m-%d_%H%M")
BACKUP_FILE="$BACKUP_DIR/bica-backup-$TIMESTAMP.tar.gz"

# Exporta senha
export PGPASSWORD="$DB_PASSWORD"

# Executa o backup
pg_dump -h $DB_HOST -p $DB_PORT -U $DB_USER -F c $DB_NAME | gzip | openssl enc -aes-256-cbc -salt -out "$BACKUP_FILE" -k "$ENCRYPTION_KEY"

# Limpa backups antigos
find "$BACKUP_DIR" -type f -name "bica-backup-*.tar.gz" -mtime +$RETENTION_DAYS -exec rm -f {} \;

# Mensagem de sucesso
echo "Backup concluído: $BACKUP_FILE"
