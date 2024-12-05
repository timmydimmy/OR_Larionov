# Используем базовый образ Ubuntu
FROM ubuntu:20.04

# Установка SSH-сервера
RUN apt-get update && apt-get install -y openssh-server && mkdir /var/run/sshd

# Установка пароля для пользователя root
RUN echo 'root:rootpassword' | chpasswd

# Разрешаем root-доступ по SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Открываем порт 22 для SSH
EXPOSE 22

# Запускаем SSH-сервер
CMD ["/usr/sbin/sshd", "-D"]