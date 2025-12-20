#!/bin/bash

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Функция для вывода сообщений
print_message() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Проверка операционной системы
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "Этот скрипт предназначен только для macOS"
    exit 1
fi

print_message "Установка Neovim конфигурации..."
echo

# Проверка зависимостей
print_message "Проверка зависимостей..."

# Проверка Homebrew
if ! command -v brew &> /dev/null; then
    print_warning "Homebrew не установлен. Установить? (y/n)"
    read -r response
    if [[ "$response" == "y" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        print_error "Homebrew необходим для установки зависимостей"
        exit 1
    fi
fi
print_success "Homebrew установлен"

# Проверка и установка Neovim
if ! command -v nvim &> /dev/null; then
    print_warning "Neovim не установлен. Устанавливаю через Homebrew..."
    brew install neovim
else
    print_success "Neovim установлен ($(nvim --version | head -n1))"
fi

# Проверка версии Neovim (требуется >= 0.9.0)
nvim_version=$(nvim --version | head -n1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -n1)
required_version="0.9.0"
if [ "$(printf '%s\n' "$required_version" "$nvim_version" | sort -V | head -n1)" != "$required_version" ]; then
    print_error "Требуется Neovim >= $required_version (установлена: $nvim_version)"
    print_warning "Обновить Neovim? (y/n)"
    read -r response
    if [[ "$response" == "y" ]]; then
        brew upgrade neovim
    else
        exit 1
    fi
fi

# Проверка Git
if ! command -v git &> /dev/null; then
    print_error "Git не установлен. Установите Git и попробуйте снова."
    exit 1
fi
print_success "Git установлен"

# Проверка Node.js (для некоторых LSP серверов)
if ! command -v node &> /dev/null; then
    print_warning "Node.js не установлен. Некоторые LSP серверы могут не работать."
    print_warning "Установить Node.js? (y/n)"
    read -r response
    if [[ "$response" == "y" ]]; then
        brew install node
    fi
else
    print_success "Node.js установлен ($(node --version))"
fi

# Проверка Python3 (для некоторых LSP серверов)
if ! command -v python3 &> /dev/null; then
    print_warning "Python3 не установлен. Некоторые LSP серверы могут не работать."
    print_warning "Установить Python3? (y/n)"
    read -r response
    if [[ "$response" == "y" ]]; then
        brew install python3
    fi
else
    print_success "Python3 установлен ($(python3 --version))"
fi

# Проверка Go (опционально, для разработки на Go)
if ! command -v go &> /dev/null; then
    print_warning "Go не установлен (опционально для разработки на Go)"
else
    print_success "Go установлен ($(go version | awk '{print $3}'))"
fi

echo
print_message "Установка конфигурации Neovim..."

# Определение путей
CONFIG_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Создание бэкапа существующей конфигурации
if [ -d "$CONFIG_DIR" ]; then
    print_warning "Обнаружена существующая конфигурация Neovim"
    print_warning "Создать бэкап и продолжить? (y/n)"
    read -r response
    if [[ "$response" != "y" ]]; then
        print_error "Установка отменена"
        exit 1
    fi

    print_message "Создание бэкапа в $BACKUP_DIR..."
    mv "$CONFIG_DIR" "$BACKUP_DIR"
    print_success "Бэкап создан"
fi

# Копирование конфигурации
print_message "Копирование конфигурации..."

if [ "$SCRIPT_DIR" == "$CONFIG_DIR" ]; then
    print_success "Конфигурация уже находится в правильной директории"
else
    mkdir -p "$(dirname "$CONFIG_DIR")"
    cp -r "$SCRIPT_DIR" "$CONFIG_DIR"
    print_success "Конфигурация скопирована в $CONFIG_DIR"
fi

# Удаление ненужных файлов
rm -f "$CONFIG_DIR/.git" 2>/dev/null
rm -f "$CONFIG_DIR/install.sh" 2>/dev/null

# Очистка старых данных плагинов
print_message "Очистка старых данных..."
rm -rf "$HOME/.local/share/nvim/lazy" 2>/dev/null
rm -rf "$HOME/.local/state/nvim" 2>/dev/null
rm -rf "$HOME/.cache/nvim" 2>/dev/null
print_success "Очистка завершена"

# Установка плагинов
echo
print_message "Установка плагинов через lazy.nvim..."
print_warning "Это может занять несколько минут..."
echo

nvim --headless "+Lazy! sync" +qa

if [ $? -eq 0 ]; then
    print_success "Плагины успешно установлены"
else
    print_warning "Возможны проблемы при установке плагинов. Проверьте вручную."
fi

# Установка LSP серверов через Mason
echo
print_message "Установка LSP серверов через Mason..."
print_warning "Это может занять несколько минут..."

nvim --headless -c "MasonInstallAll" -c "qa" 2>/dev/null || true

echo
print_success "================================"
print_success "Установка завершена!"
print_success "================================"
echo
print_message "Что дальше:"
echo "  1. Запустите Neovim: nvim"
echo "  2. Дождитесь завершения установки плагинов (если не завершилась)"
echo "  3. Выполните :checkhealth для проверки"
echo "  4. Установите LSP серверы: :Mason"
echo
print_message "Полезные команды:"
echo "  :Lazy         - Управление плагинами"
echo "  :Mason        - Управление LSP серверами"
echo "  :checkhealth  - Проверка здоровья конфигурации"
echo
print_message "Горячие клавиши:"
echo "  <leader>v     - Открыть файловое дерево"
echo "  <leader>f     - Поиск в файлах"
echo "  <leader>o     - Поиск файлов"
echo "  K             - Показать документацию"
echo "  gd            - Перейти к определению"
echo
if [ -d "$BACKUP_DIR" ]; then
    print_message "Бэкап сохранен в: $BACKUP_DIR"
fi
echo
print_success "Приятного использования Neovim! 🚀"
