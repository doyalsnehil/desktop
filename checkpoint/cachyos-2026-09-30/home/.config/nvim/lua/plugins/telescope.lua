return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				sorting_strategy = "ascending",
				preview = {
					treesitter = false,
				},
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},
					width = 0.87,
					height = 0.80,
				},
				file_ignore_patterns = { "node_modules", ".git/" },
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			},
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
			},
		})

		-- Load fzf extension for better sorting performance
		pcall(telescope.load_extension, "fzf")
	end,
}
