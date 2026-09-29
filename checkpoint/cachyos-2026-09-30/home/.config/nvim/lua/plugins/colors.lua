function ColorMyPencils(color)
	color = color or "rose-pine-moon"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	{
		"erikbackman/brightburn.vim",
		lazy = true,
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		opts = {
			style = "storm",
			transparent = true,
			terminal_colors = true,
			styles = {
				comments = { italic = false },
				keywords = { italic = false },
				sidebars = "dark",
				floats = "dark",
			},
		},
	},
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		lazy = true,
		opts = {
			terminal_colors = true,
			undercurl = true,
			underline = false,
			bold = true,
			italic = {
				strings = false,
				emphasis = false,
				comments = false,
				operators = false,
				folds = false,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			inverse = true,
			contrast = "",
			dim_inactive = false,
			transparent_mode = false,
		},
	},
}
