LOCAL_DIR="/Users/dmitry/Downloads/WORK_AND_STUFF/REPA/OR_Larionov/Lab9/testsync/"
REMOTE_USER="root"
REMOTE_HOST="localhost"
REMOTE_PORT=2222
REMOTE_DIR="/mnt/project/obj"
IGNORE_FILE="/Users/dmitry/Downloads/WORK_AND_STUFF/REPA/OR_Larionov/Lab9/ignore-file.txt" # Файл с шаблонами для исключения
EMAIL="mrnail@mail.ru"
LOG_FILE="/Users/dmitry/Downloads/WORK_AND_STUFF/REPA/OR_Larionov/Lab9/sync_report.log"

echo "Синхронизация локальной папки с удалённой началась..." > "$LOG_FILE"

rsync -avz --delete --exclude-from="$IGNORE_FILE" \
      -e "ssh -p $REMOTE_PORT" \
      "$LOCAL_DIR/" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR" >> "$LOG_FILE" 2>&1

echo "Синхронизация удалённой папки с локальной началась..." >> "$LOG_FILE"

rsync -avz --delete --exclude-from="$IGNORE_FILE" \
      -e "ssh -p $REMOTE_PORT" \
      "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/" "$LOCAL_DIR" >> "$LOG_FILE" 2>&1

echo "Синхронизация завершена. Отправка отчёта..." >> "$LOG_FILE"
mail -s "Отчёт о синхронизации" "$EMAIL" < "$LOG_FILE"

echo "Отчёт отправлен на $EMAIL"