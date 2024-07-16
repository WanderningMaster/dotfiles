local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', function()
    builtin.find_files({ hidden = true })
end)
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ss', function()
	builtin.grep_string({ search = vim.fn.input("Find me daddy> ") });
end)
