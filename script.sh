#!/bin/bash

show_users() {
    cut -d: -f1,6 /etc/passwd | sort
}

show_processes() {
    ps -eo pid,cmd --sort=pid
}

show_help() {
    echo "Использование: $0 [OPTIONS]"
    echo "  -u, --users       показать пользователей"
    echo "  -p, --processes   показать процессы"
    echo "  -l, --log FILE    выводить результат в файл"
    echo "  -e, --errors FILE выводить ошибки в файл"
    echo "  -h, --help        показать справку"
    exit 0
}

check_access() {
    # Проверка возможности записи в указанный файл
    touch "$1" 2>/dev/null
    if [[ $? -ne 0 ]]; then
        echo "Ошибка: нет доступа к файлу '$1'" >&2
        exit 1
    fi
}

  GNU nano 8.7                       script.sh                        Modified
show_help() {
    echo "Использование: $0 [OPTIONS]"
    echo "  -u, --users       показать пользователей"
    echo "  -p, --processes   показать процессы"
    echo "  -l, --log FILE    выводить результат в файл"
    echo "  -e, --errors FILE выводить ошибки в файл"
    echo "  -h, --help        показать справку"
    exit 0
}

check_access() {
    # Проверка возможности записи в указанный файл
    touch "$1" 2>/dev/null
    if [[ $? -ne 0 ]]; then
        echo "Ошибка: нет доступа к файлу '$1'" >&2
        exit 1
    fi
}

LOG_FILE=""
ERR_FILE=""
