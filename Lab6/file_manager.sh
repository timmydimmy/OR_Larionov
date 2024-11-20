#!/bin/bash

# Создаем директорию
echo "Создаем директорию 'my_directory'..."
mkdir my_directory

# Переходим в директорию
cd my_directory || { echo "Не удалось перейти в директорию."; exit 1; }

# Создаем несколько файлов
echo "Создаем файлы file1.txt, file2.txt и file3.txt..."
touch file1.txt file2.txt file3.txt

# Проверяем, что файлы созданы
echo "Список файлов в директории:"
ls

# Удаляем файлы
echo "Удаляем файлы..."
rm file1.txt file2.txt file3.txt

# Проверяем, что файлы удалены
echo "Список файлов после удаления:"
ls

# Выходим из директории
cd ..

# Удаляем директорию
echo "Удаляем директорию 'my_directory'..."
rmdir my_directory

echo "Скрипт завершён."
