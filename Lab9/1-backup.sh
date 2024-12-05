#!/bin/bash

# Параметры
SOURCE_DIR="/mnt/project/"   # Путь к директории для резервного копирования в контейнере
BACKUP_NAME="backup_$(date +%Y%m%d_%H%M%S).tar.gz" # Имя архива с текущей датой
REMOTE_USER="root"                      # Логин на удалённом сервере (root для SSH в Docker-контейнер)
REMOTE_HOST="localhost"                 # Адрес локального Docker-сервера (или IP вашего контейнера)
REMOTE_PORT="2222"                      # Порт SSH на локальном сервере Docker
REMOTE_DIR="/mnt/project/copy/"  # Папка для архивов на удалённом сервере
MAX_BACKUPS=3                           # Максимальное количество резервных копий на сервере

# Создание архива в контейнере
echo "Создаём архив $BACKUP_NAME из директории $SOURCE_DIR..."
docker exec -it ssh-server-instance tar -czf "/tmp/$BACKUP_NAME" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

# Копирование архива с контейнера на локальную машину
docker cp ssh-server-instance:/tmp/$BACKUP_NAME ./

# Копирование архива на удалённый сервер
echo "Копируем архив на удалённый сервер $REMOTE_HOST..."
scp -P $REMOTE_PORT "$BACKUP_NAME" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"

# Удаление старых архивов на удалённом сервере
echo "Удаляем старые архивы на удалённом сервере..."
ssh -p $REMOTE_PORT "$REMOTE_USER@$REMOTE_HOST" << EOF
cd "$REMOTE_DIR"
# Удаляем архивы, если их больше MAX_BACKUPS
ARCHIVES=($(ls -t))
if [ \${#ARCHIVES[@]} -gt $MAX_BACKUPS ]; then
    echo "Удаляем старые архивы..."
    # Удаляем архивы начиная с (MAX_BACKUPS+1) по порядку
    for i in \$(seq $MAX_BACKUPS \${#ARCHIVES[@]}); do
        rm -f "\${ARCHIVES[\$i]}"
    done
fi
EOF

# Удаление локального архива
echo "Удаляем локальный архив $BACKUP_NAME..."
rm -f "$BACKUP_NAME"

echo "Резервное копирование завершено."


