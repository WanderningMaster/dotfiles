-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- {
  --   'github/copilot.vim',
  -- },
  {
    import = 'custom.plugins.fugitive',
  },
  {
    import = 'custom.plugins.harpoon',
  },
  {
    import = 'custom.plugins.oil',
  },
  {
    import = 'custom.plugins.neorg',
  },
}
