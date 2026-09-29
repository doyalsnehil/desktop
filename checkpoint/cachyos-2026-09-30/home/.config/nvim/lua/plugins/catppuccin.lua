return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = true,
	opts = {
		transparent_background = true,
		term_colors = true,
		integrations = {
			neotree = true,
			gitsigns = true,
			treesitter = true,
			notify = true,
			noice = true,
			which_key = true,
			indent_blankline = { enabled = true },
			dap = true,
			dap_ui = true,
		},
	},
}
