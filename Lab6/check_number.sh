#!/bin/bash
# Запрашиваем число у пользователя
echo -n "Введите число: "
read number

# Проверяем, является ли введенное значение числом
if ! [[ "$number" =~ ^-?[0-9]+$ ]]; then
    echo "Ошибка: Это не число!"
    exit 1
fi

# Проверяем, какое это число
if [ "$number" -gt 0 ]; then
    echo "Это положительное число."
elif [ "$number" -lt 0 ]; then
    echo "Это отрицательное число."
else
    echo "Это ноль."
fi