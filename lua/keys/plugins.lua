require('keys/alias')

-- LSP (все горячие клавиши начинаются с g), кроме ховера
nm('K', '<cmd>Lspsaga hover_doc<CR>')              -- Ховер для объекта
nm('gf', '<cmd>lua vim.lsp.buf.format()<CR>')      -- Форматировать документ
nm('ga', '<cmd>Lspsaga code_action<CR>')           -- Действия с кодом
nm('gR', '<cmd>Lspsaga rename<CR>')                -- Переименовать объект
nm('gs', '<cmd>Lspsaga finder<CR>')                -- Найти определения, ссылки и имплементации
nm('gp', '<cmd>Lspsaga peek_definition<CR>')       -- Посмотреть определение
nm(']d', '<cmd>Lspsaga diagnostic_jump_next<CR>')  -- Следующая диагностика
nm('[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>')  -- Предыдущая диагностика
nm('gl', '<cmd>Lspsaga show_line_diagnostics<CR>') -- Диагностика текущей строки
nm('<leader>o', '<cmd>Lspsaga outline<CR>')        -- Символы текущего файла

-- Отркыть NvimTree
nm('<leader>v', '<cmd>Neotree toggle<CR>')

-- Telescope
nm('gd', '<cmd>Lspsaga goto_definition<CR>')       -- Объявления в LSP
nm('gi', '<cmd>Telescope lsp_implementations<CR>')     -- Объявления в LSP
nm('gr', '<cmd>Lspsaga finder ref<CR>')            -- Ссылки в LSP
nm('<leader>p', '<cmd>Telescope oldfiles<CR>')     -- Просмотр недавних файлов
nm('<leader>P', '<cmd>Telescope git_files<CR>')    -- Поиск файлов
nm('<leader>b', '<cmd>Telescope git_branches<CR>') -- Ветки в Git
nm('<leader>f', '<cmd>Telescope live_grep<CR>')    -- Поиск строки
nm('<leader>q', '<cmd>Telescope buffers<CR>')  	   -- Буфферы

-- BufferLine
-- nm('<leader>c', '<cmd>bd<CR>')                  -- Закрыть буффер
nm('<leader>c', '<cmd>BufferLinePickClose<CR>') -- Выбрать буффер который надо закрыть 
nm('<leader>[', '<cmd>BufferLineCyclePrev<CR>') -- Перейти в предыдущий буффер
nm('<leader>]', '<cmd>BufferLineCycleNext<CR>') -- Перейти в следующий буффер

-- Go run coommand
nm('gor', '<cmd>GoRun<CR>')

-- copy current file path with line number to system clipboard
nm('<leader>wd', '<cmd>lua local file = vim.fn.expand("%:p"); local line = vim.fn.line("."); vim.fn.setreg("+", string.format("%s:%d", file, line))<CR>')
im('<leader>wd', '<C-o>:lua local file = vim.fn.expand("%:p"); local line = vim.fn.line("."); vim.fn.setreg("+", string.format("%s:%d", file, line))<CR>')
-- copy current file path relative to repo root to system clipboard
nm('<leader>wr', '<cmd>lua local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]; local file = vim.fn.expand("%:p"); local rel = file; if root ~= nil and root ~= "" and file:sub(1, #root) == root then rel = file:sub(#root + 2); end; vim.fn.setreg("+", rel)<CR>')
im('<leader>wr', '<cmd>lua local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]; local file = vim.fn.expand("%:p"); local rel = file; if root ~= nil and root ~= "" and file:sub(1, #root) == root then rel = file:sub(#root + 2); end; vim.fn.setreg("+", rel)<CR>')
-- copy remote URL for current file + line to system clipboard (fugitive)
nm('<leader>wg', '<cmd>lua local out = vim.fn.execute("silent .GBrowse!"); out = out:gsub("%s+$", ""); vim.fn.setreg("+", out)<CR>')
im('<leader>wg', '<C-o>:lua local out = vim.fn.execute("silent .GBrowse!"); out = out:gsub("%s+$", ""); vim.fn.setreg("+", out)<CR>')

-- turn to insert mode at the end of file
nm('<C-y>', 'G$o')

-- move cursor 3 lines
nm('<C-k>', '3k')
nm('<C-j>', '3j')
vm('<C-k>', '3k')
vm('<C-j>', '3j')
im('<C-k>', '<C-o>3k')
im('<C-j>', '<C-o>3j')

-- move cursor 10 lines
nm('<C-e>', '10k')
nm('<C-b>', '10j')
vm('<C-e>', '10k')
vm('<C-b>', '10j')
im('<C-e>', '<C-o>10k')
im('<C-b>', '<C-o>10j')


-- line/multiple lines up and down
nm('∆', ':m .+1<CR>==')
nm('˚', ':m .-2<CR>==')
vm('∆', ":m '>+1<CR>gv=gv")
vm('˚', ":m '<-2<CR>gv=gv")
im('∆', '<Esc>:m .+1<CR>==gi')
im('˚', '<Esc>:m .-2<CR>==gi')

-- this is for not mac
-- -- line/multiple lines up and down
-- nm('<A-j>', ':m .+1<CR>==')
-- nm('<A-k>', ':m .-2<CR>==')
-- im('<A-j>', '<Esc>:m .+1<CR>==gi')
-- im('<A-k>', '<Esc>:m .-2<CR>==gi')
-- vm('<A-j>', ':m \'>+1<CR>gv=gv')
-- vm('<A-k>', ':m \'<-2<CR>gv=gv')
