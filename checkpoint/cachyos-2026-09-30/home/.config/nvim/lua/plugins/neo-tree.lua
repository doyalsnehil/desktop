return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		keys = {
			{ "<leader>e", ":Neotree focus<CR>", desc = "Focus Neo-tree", silent = true },
			{ "<leader>r", ":Neotree reveal<CR>", desc = "Reveal in Neo-tree", silent = true },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				default_component_configs = {
					git_status = {
						symbols = {
							added = "✚",
							deleted = "✖",
							modified = "󰰑 ",
							renamed = "󰁕",
							untracked = "󰦱 ",
							ignored = "◌",
							unstaged = "✗",
							staged = "",
							conflict = "",
						},
					},
				},
				window = {
					width = 35,
					mappings = {
						["<space>"] = "none",
					},
				},
				filesystem = {
					follow_current_file = { enabled = true },
					filtered_items = {
						hide_dotfiles = false,
						hide_gitignored = false,
					},
				},
			})

			require("nvim-web-devicons").setup({
				override_by_extension = {
					css = {
						icon = "",
						color = "#61afef",
						cterm_color = "67",
						name = "css",
					},
				},
			})
		end,
	},
}
