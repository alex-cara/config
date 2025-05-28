-- TODO: Important to seperate options and keymaps, will be done later
-- I need too set stuff of for surrond
--
-- Adding move around viusal mode text up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- A general make undodir and file
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.termguicolors = true

-- Useful for bash files
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- Harpoon
local mark = require 'harpoon.mark'
local ui = require 'harpoon.ui'

vim.keymap.set('n', '<leader>ha', mark.add_file)
vim.keymap.set('n', '<leader>he', ui.toggle_quick_menu)

vim.keymap.set('n', '<leader>h1', function()
  ui.nav_file(1)
end)
vim.keymap.set('n', '<leader>h2', function()
  ui.nav_file(2)
end)
vim.keymap.set('n', '<leader>h3', function()
  ui.nav_file(3)
end)
vim.keymap.set('n', '<leader>h4', function()
  ui.nav_file(4)
end)

-- Undotree
vim.keymap.set('n', '<leader>uu', vim.cmd.UndotreeToggle)

-- Oil
vim.keymap.set('n', '<leader>f', "<cmd>lua require('oil').toggle_float()<CR>", { desc = 'Oil' })
