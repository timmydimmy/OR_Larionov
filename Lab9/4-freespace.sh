# === Настройки ===
REMOTE_USER="root"
REMOTE_HOST="localhost"
REMOTE_PORT=2222
THRESHOLD=20 # Пороговое значение свободного места в процентах
EMAIL="mrnail@mail.ru"

# === Проверка свободного места на удалённом сервере ===
FREE_SPACE=$(ssh -p "$REMOTE_PORT" "$REMOTE_USER@$REMOTE_HOST" \
    "df -h / | awk 'NR==2 {print \$(NF-1)}' | sed 's/%//g'")

# === Логика сравнения ===
if [ "$FREE_SPACE" -lt "$THRESHOLD" ]; then
    echo "Внимание: на сервере $REMOTE_HOST осталось только $FREE_SPACE% свободного места." | mail -s "Уведомление: свободное место заканчивается" "$EMAIL"
    echo "Уведомление отправлено на $EMAIL"
else
    echo "Свободного места на сервере достаточно: $FREE_SPACE%"
fi