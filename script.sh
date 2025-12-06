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

while [[ $# -gt 0 ]]; do
    case "$1" in
        -l|--log)
            LOG_FILE="$2"
            check_access "$LOG_FILE"
            shift 2 ;;
        -e|--errors)
            ERR_FILE="$2"
            check_access "$ERR_FILE"
            shift 2 ;;
        *)
            args+=("$1")
            shift ;;
    esac
done

actions=()

set -- "${args[@]}"

[[ -n "$ERR_FILE" ]] && exec 2>"$ERR_FILE"
[[ -n "$LOG_FILE" ]] && exec >"$LOG_FILE"

OPTS=$(getopt -o uphl:e: --long users,processes,help,log:,errors: -n "script" -- "$@")
[[ $? -ne 0 ]] && echo "Ошибка аргументов. Используйте -h." >&2 && exit 1

eval set -- "$OPTS"

while true; do
    case "$1" in
        -u|--users)
            actions+=("users")
            shift ;;
        -p|--processes)
            actions+=("processes")
            shift ;;
        -h|--help)
            actions+=("help")
            shift ;;
        -l|--log|-e|--errors)
            shift 2 ;; # уже обработано
        --)
            shift ; break ;;
    esac
done
