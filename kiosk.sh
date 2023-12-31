#!/bin/bash

# Очищаем экран
clear

# Отключаем экранный режим ожидания и блокировку
xset s off
xset -dpms

# Запускаем веб-браузер в полноэкранном режиме
# Замените "http://example.com" на URL вашей веб-страницы
firefox http://example.com -kiosk &

# Получаем и сохраняем идентификатор процесса браузера
browser_pid=$!

# Функция для перезапуска страницы киоска
restart_kiosk() {
    # Убиваем процесс браузера
    kill $browser_pid

    # Запускаем новый экземпляр веб-браузера
    firefox http://example.com -kiosk &

    # Обновляем идентификатор процесса браузера
    browser_pid=$!
}

# Функция для проверки неактивного времени пользователя
check_idle_time() {
    # Получаем текущее неактивное время пользователя в миллисекундах
    idle_time=$(xprintidle)

    # Проверяем, если время бездействия пользователя превышает 5 секунд (5000 миллисекунд)
    if (( idle_time > 120000 )); then
        # Вызываем функцию перезапуска страницы киоска
        restart_kiosk
    fi
    # Запускаем функцию снова через 1 секунду
    sleep 1800
    check_idle_time
}

# Запускаем функцию проверки неактивного времени пользователя
check_idle_time

