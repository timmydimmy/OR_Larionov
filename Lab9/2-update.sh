#!/bin/bash

# Параметры для подключения и отправки почты
REMOTE_USER="root"                      # Логин на удалённом сервере (root для SSH в Docker-контейнер)
REMOTE_HOST="localhost"                 # Адрес локального Docker-сервера (или IP вашего контейнера)
REMOTE_PORT="2222"  
EMAIL="mrnail@mail.ru"
SUBJECT="Server Reboot Notification"


# Подключение и выполнение команд на удалённом сервере

ssh -p $REMOTE_PORT "$REMOTE_USER@$REMOTE_HOST" << EOF
  echo 'Checking for updates...';
   apt update && sudo apt upgrade -y;
  NEED_REBOOT=\$(if [ -f /var/run/reboot-required ]; then echo 'yes'; else echo 'no'; fi);
  if [ \"\$NEED_REBOOT\" == 'yes' ]; then
    echo 'Reboot is required, rebooting now...';
    reboot;
  else
    echo 'No reboot needed';
  fi
EOF

# Проверка на перезагрузку и отправка уведомления по почте
if ssh -p $REMOTE_PORT "$REMOTE_USER@$REMOTE_HOST" "test -f /var/run/reboot-required"; then
  echo "Server rebooted after updates" | mail -s "$SUBJECT" $EMAIL
fi