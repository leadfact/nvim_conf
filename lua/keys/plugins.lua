require('keys/alias')

-- Explorer
nm('<leader>e', '<cmd>Neotree toggle<CR>')

-- Find
nm('<leader>ff', '<cmd>Telescope git_files<CR>')   -- Поиск файлов
nm('<leader>fr', '<cmd>Telescope oldfiles<CR>')    -- Недавние файлы
nm('<leader>fg', '<cmd>Telescope live_grep<CR>')   -- Поиск строки
nm('<leader>fB', '<cmd>Telescope git_branches<CR>') -- Ветки в Git

-- Git
nm('<leader>gs', '<cmd>Git<CR>')                                      -- Git status через fugitive
nm('<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<CR>') -- Вкл/выкл blame для текущей строки
nm('<leader>gB', '<cmd>Git blame<CR>')                            -- Полный git blame через fugitive
nm('<leader>gp', '<cmd>Gitsigns preview_hunk<CR>')               -- Просмотр изменений в hunk
nm('<leader>ga', '<cmd>Gitsigns stage_hunk<CR>')                 -- Добавить hunk в stage
nm('<leader>gr', '<cmd>Gitsigns reset_hunk<CR>')                 -- Откатить hunk
nm('<leader>gd', '<cmd>Gitsigns toggle_deleted<CR>')             -- Показать удаленные строки
nm(']h', '<cmd>Gitsigns next_hunk<CR>')                          -- Следующий hunk
nm('[h', '<cmd>Gitsigns prev_hunk<CR>')                          -- Предыдущий hunk

-- Buffers
nm('<leader>bb', '<cmd>Telescope buffers<CR>')       -- Буферы
nm('<leader>bd', '<cmd>BufferLinePickClose<CR>')     -- Выбрать буфер для закрытия
nm('<leader>bp', '<cmd>BufferLineCyclePrev<CR>')     -- Предыдущий буфер
nm('<leader>bn', '<cmd>BufferLineCycleNext<CR>')     -- Следующий буфер

-- Go run coommand
nm('gor', '<cmd>GoRun<CR>')

-- Yank / Share
nm('<leader>ya', '<cmd>lua require("utils.clipboard").copy_abs_path_with_line()<CR>') -- Скопировать абсолютный путь с номером строки
im('<leader>ya', '<C-o>:lua require("utils.clipboard").copy_abs_path_with_line()<CR>')
nm('<leader>yr', '<cmd>lua require("utils.clipboard").copy_repo_relative_path()<CR>') -- Скопировать путь относительно репозитория
im('<leader>yr', '<C-o>:lua require("utils.clipboard").copy_repo_relative_path()<CR>')
nm('<leader>yg', '<cmd>lua require("utils.clipboard").copy_remote_url()<CR>') -- Скопировать remote URL текущей строки
im('<leader>yg', '<C-o>:lua require("utils.clipboard").copy_remote_url()<CR>')

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
