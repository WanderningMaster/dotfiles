local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

	vim.api.nvim_create_autocmd('BufWritePre', {
		pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
		command = 'silent! EslintFixAll',
		group = vim.api.nvim_create_augroup('MyAutocmdsJavaScripFormatting', {}),
	})
	vim.api.nvim_create_autocmd('BufWritePre', {
		pattern = { '.*go' },
		callback = function()
			vim.cmd('GoFmt')
		end,
		group = vim.api.nvim_create_augroup('GoImport', {}),
	})

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            -- delay update diagnostics
            update_in_insert = true,
        }
    )
    vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = {"*.templ"},
        callback = function()
            vim.lsp.buf.format()
        end,
    })

end)

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {'tsserver', 'rust_analyzer', 'eslint', 'gopls', 'prismals', 'templ', 'clangd'},
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require('lspconfig').lua_ls.setup(lua_opts)
		end,
	}
})
local lspconfig = require('lspconfig') lspconfig.gopls.setup {}


require('lspconfig').tsserver.setup({
    init_options = { 
        preferences = { 
            importModuleSpecifierPreference = 'relative', 
            importModuleSpecifierEnding = 'minimal', 
        },  
    } 
})

vim.cmd [[autocmd BufWritePre *.go lua vim.lsp.buf.format({ async = true })]]

vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*.go', callback = function() vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true }) end })

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  })
})
