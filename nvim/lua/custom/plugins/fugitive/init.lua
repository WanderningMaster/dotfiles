return {
  {
    'tpope/vim-fugitive',
    config = function()
      -- require('fugitive').setup {}
      --
      vim.keymap.set('n', '<leader>gdf', function()
        vim.cmd 'Git diff'
      end)
    end,
  },
}
