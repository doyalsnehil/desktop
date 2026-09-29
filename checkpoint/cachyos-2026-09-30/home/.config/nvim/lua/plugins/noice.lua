-- return {
-- 	{
-- 		"folke/noice.nvim",
-- 		event = "VeryLazy",
-- 		dependencies = {
-- 			"MunifTanjim/nui.nvim",
-- 		},
-- 		opts = {
-- 			cmdline = {
-- 				enabled = true,
-- 				view = "cmdline_popup",
-- 				format = {
-- 					cmdline = { pattern = "^:", icon = "", lang = "vim" },
-- 					search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
-- 					search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
-- 					filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
-- 					lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
-- 					help = { pattern = "^:%s*he?l?p?%s+", icon = "?" },
-- 				},
-- 			},
-- 			messages = {
-- 				enabled = true,
-- 				view = "mini",
-- 				view_error = "mini",
-- 				view_warn = "mini",
-- 			},
-- 			popupmenu = {
-- 				enabled = true,
-- 				backend = "nui",
-- 			},
-- 			lsp = {
-- 				override = {
-- 					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
-- 					["vim.lsp.util.stylize_markdown"] = true,
-- 				},
-- 				hover = { enabled = true },
-- 				signature = { enabled = false }, -- blink.cmp handles this
-- 			},
-- 			presets = {
-- 				bottom_search = false,
-- 				command_palette = true,
-- 				long_message_to_split = true,
-- 				inc_rename = false,
-- 				lsp_doc_border = true,
-- 			},
-- 		},
-- 	},
-- }
-- ```lua
--
return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",

		dependencies = {
			"MunifTanjim/nui.nvim",
		},

		opts = {
			cmdline = {
				enabled = true,
				view = "cmdline_popup",

				format = {
					cmdline = {
						pattern = "^:",
						icon = "",
						lang = "vim",
					},

					search_down = {
						kind = "search",
						pattern = "^/",
						icon = " ",
						lang = "regex",
					},

					search_up = {
						kind = "search",
						pattern = "^%?",
						icon = " ",
						lang = "regex",
					},

					filter = {
						pattern = "^:%s*!",
						icon = "$",
						lang = "bash",
					},

					lua = {
						pattern = {
							"^:%s*lua%s+",
							"^:%s*lua%s*=%s*",
							"^:%s*=%s*",
						},
						icon = "",
						lang = "lua",
					},

					help = {
						pattern = "^:%s*he?l?p?%s+",
						icon = "?",
					},
				},
			},

			lsp = {
				progress = {
					enabled = false,
				},

				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},

				hover = {
					enabled = true,
				},

				signature = {
					enabled = false,
				},
			},

			messages = {
				enabled = true,
				view = "mini",
				view_error = "mini",
				view_warn = "mini",
			},

			popupmenu = {
				enabled = true,
				backend = "nui",
			},

			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
		},
	},
}
