#!/bin/bash

# Функция для сложения
add() {
    echo "Сумма: $(($1 + $2))"
}

# Функция для вычитания
subtract() {
    echo "Разность: $(($1 - $2))"
}

# Функция для умножения
multiply() {
    echo "Произведение: $(($1 * $2))"
}

# Функция для деления
divide() {
    if [ "$2" -eq 0 ]; then
        echo "Ошибка: Деление на ноль невозможно."
    else
        echo "Частное: $(($1 / $2))"
    fi
}

# Запрашиваем у пользователя два числа
echo "Введите первое число:"
read -r num1

echo "Введите второе число:"
read -r num2

# Запрашиваем операцию
echo "Выберите операцию (add, subtract, multiply, divide):"
read -r operation

# Выполняем операцию
case $operation in
    add)
        add "$num1" "$num2"
        ;;
    subtract)
        subtract "$num1" "$num2"
        ;;
    multiply)
        multiply "$num1" "$num2"
        ;;
    divide)
        divide "$num1" "$num2"
        ;;
    *)
        echo "Ошибка: Неизвестная операция. Пожалуйста, выберите одну из: add, subtract, multiply, divide."
        ;;
esac
