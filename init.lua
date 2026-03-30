-- Базовые настройки
require('base/search')
require('base/tabs')
require('base/other')
require('autocmds')
require('lsp.diagnostics').setup()

-- Инициализация lazy.nvim
require('lazy-setup')

-- Горячие клавиши
require('keys/plugins')
