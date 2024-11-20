#!/bin/bash

# Проверяем, переданы ли два аргумента: исходная и целевая директории
if [ "$#" -ne 2 ]; then
    echo "Ошибка: Укажите исходную и целевую директории."
    echo "Пример: ./backup.sh source_dir target_dir"
    exit 1
fi

# Читаем директории из аргументов
source_dir=$1
target_dir=$2

# Проверяем, существует ли исходная директория
if [ ! -d "$source_dir" ]; then
    echo "Ошибка: Исходная директория '$source_dir' не существует."
    exit 1
fi

# Создаём целевую директорию, если она не существует
mkdir -p "$target_dir"

# Получаем текущую дату
current_date=$(date +%Y-%m-%d)

# Копируем файлы с добавлением текущей даты к имени
for file in "$source_dir"/*; do
    if [ -f "$file" ]; then
        # Получаем имя файла без пути
        filename=$(basename "$file")
        # Копируем файл в целевую директорию с добавлением даты
        cp "$file" "$target_dir/${filename%.*}_$current_date.${filename##*.}"
    fi
done

echo "Все файлы из '$source_dir' скопированы в '$target_dir' с добавлением даты."
