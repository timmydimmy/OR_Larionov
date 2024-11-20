#!/bin/bash

# Проверяем, указан ли файл в качестве аргумента
if [ "$#" -ne 1 ]; then
    echo "Ошибка: Укажите имя файла в качестве аргумента."
    echo "Пример: ./read_file.sh filename.txt"
    exit 1
fi

# Проверяем, существует ли файл
if [ ! -f "$1" ]; then
    echo "Ошибка: Файл '$1' не существует."
    exit 1
fi

# Читаем файл строка за строкой
while IFS= read -r line; do
    echo "$line"
done < "$1"

