return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "auto",
				dark_variant = "moon",
				dim_inactive_windows = false,
				extend_background_behind_borders = true,

				enable = {
					terminal = true,
					legacy_highlights = false,
					migrations = true,
				},

				styles = {
					bold = true,
					italic = true,
					transparency = true,
				},
			})
		end,
	},
}
