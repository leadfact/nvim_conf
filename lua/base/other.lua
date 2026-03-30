local opt = vim.opt
local g = vim.g
-- [[PANELS SETTING]]
-- Vertical splits become on the right
opt.splitright = true

-- Horizontal splits become on the down
opt.splitbelow = true

-- [[ADDITIONAL SETTINGS]]
-- use the system clipboard
opt.clipboard = 'unnamedplus'

-- auto-reload files changed outside nvim
opt.autoread = true
opt.updatetime = 100

-- Disable auto-completion of files at the end (отключаем автодополнение файлов в конце)
opt.fixeol = false

-- Auto-completion (built into Novim)
opt.completeopt = 'menuone,noselect'

-- opt.guifont= ':h4'              -- Изменить размер шрифта
opt.guifont= 'FiraCode Nerd Font:h9'              -- Изменить размер шрифта
opt.colorcolumn = '80'              -- Разделитель на 80 символов
opt.cursorline = true               -- Подсветка строки с курсором
opt.spelllang= { 'en_us', 'ru' }    -- Словари рус eng
opt.spell = true
opt.number = true                   -- Включаем нумерацию строк
opt.relativenumber = false          -- Вкл. относительную нумерацию строк
opt.so=999                          -- Курсор всегда в центре экрана
opt.termguicolors = true            --  24-bit RGB colors

g.translate_source = 'ru'
g.translate_target = 'en'
g.fugitive_gitlab_domains = { 'git.itcrew.info' }

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})
