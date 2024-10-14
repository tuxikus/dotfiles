

vim.keymap.set('n', '<leader>ws', "<CMD>split<CR>", { desc = "Split window horizonally" })
vim.keymap.set('n', '<leader>wv', "<CMD>vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set('n', '<leader>wq', "<CMD>q<CR>", { desc = "Close window" })
vim.keymap.set('n', '<leader>wd', "<CMD>q<CR>", { desc = "Close window" })



vim.keymap.set('n', '<leader>.', "<CMD>Explore<CR>", { desc = "Netrw" })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
vim.keymap.set('n', '<leader>/', builtin.live_grep, {})
vim.keymap.set('n', '<leader>,', builtin.buffers, {})
vim.keymap.set('n', '<leader>hf', builtin.help_tags, {})
