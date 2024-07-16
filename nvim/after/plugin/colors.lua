require('rose-pine').setup({
    -- disable_background = true,
    -- variant = 'main',
    -- dark_variant = 'main',
    disable_italics = true,
})

function ColorMyPencils(color)
    -- vim.cmd("colorscheme nightfly")
	color = color or "rose-pine"
    vim.g.nightflyItalics = false
    vim.g.nightflyTransparent = true
	vim.cmd.colorscheme(color)

 --    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
