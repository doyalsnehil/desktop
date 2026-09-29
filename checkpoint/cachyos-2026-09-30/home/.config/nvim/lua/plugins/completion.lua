return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				dependencies = {
					"rafamadriz/friendly-snippets",
				},
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/snippets" })
				end,
			},
		},

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			snippets = { preset = "luasnip" },

			keymap = {
				preset = "none",
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<C-Space>"] = { "show", "fallback" },
				["<C-e>"] = { "cancel", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				-- Smart Tab: if menu is open -> next item, if ghost text -> accept, else fallback
				["<Tab>"] = {
					function(cmp)
						if cmp.is_menu_visible() then
							return cmp.select_next()
						elseif cmp.is_ghost_text_visible() then
							return cmp.accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = {
					function(cmp)
						if cmp.is_menu_visible() then
							return cmp.select_prev()
						end
					end,
					"snippet_backward",
					"fallback",
				},
			},

			completion = {
				-- Show completion popup instantly
				trigger = {
					show_on_insert_on_trigger_character = true,
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
					window = {
						border = "rounded",
						winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
					},
				},
				menu = {
					border = "rounded",
					scrollbar = false,
					winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
					draw = {
						treesitter = { "lsp" },
						padding = { 1, 1 },
						gap = 1,
						columns = {
							{ "kind_icon", gap = 1 },
							{ "label", "label_description", gap = 1 },
						},
					},
				},
				list = {
					selection = { preselect = true, auto_insert = false },
					max_items = 20,
				},
				-- Ghost text: always wired up, toggled via vim.g at runtime
				ghost_text = {
					enabled = function()
						return vim.g.blink_ghost_text == true
					end,
					show_with_selection = true,
					show_without_selection = true,
					show_with_menu = true,
					show_without_menu = true,
				},
			},

			signature = {
				enabled = true,
				window = { border = "rounded" },
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					sql = { "dadbod", "buffer", "path" },
					mysql = { "dadbod", "buffer", "path" },
					plsql = { "dadbod", "buffer", "path" },
				},
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
					-- Snippets rank just below LSP, above buffer
					snippets = {
						score_offset = 5,
					},
					-- Buffer source: low priority, limited items
					buffer = {
						max_items = 3,
						score_offset = -5,
					},
					lsp = {
						score_offset = 10,
					},
				},
			},

			cmdline = {
				enabled = true,
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			-- Fuzzy matching tuning
			fuzzy = {
				implementation = "prefer_rust_with_warning",
			},
		},

		config = function(_, opts)
			require("blink.cmp").setup(opts)

			-- Minimal transparent completion highlights
			-- Applied after setup and on colorscheme change to override blink defaults
			local function set_blink_highlights()
				local function hl(name, val)
					vim.api.nvim_set_hl(0, name, val)
				end

				-- Menu: fully transparent background
				hl("BlinkCmpMenu", { bg = "NONE", fg = "#e0def4" })
				hl("BlinkCmpMenuBorder", { bg = "NONE", fg = "#6e6a86" })
				hl("BlinkCmpMenuSelection", { bg = "#2a283e", bold = true })

				-- Labels: transparent
				hl("BlinkCmpLabel", { bg = "NONE", fg = "#e0def4" })
				hl("BlinkCmpLabelMatch", { fg = "#9ccfd8", bg = "NONE", bold = true })
				hl("BlinkCmpLabelDetail", { fg = "#6e6a86", bg = "NONE" })
				hl("BlinkCmpLabelDescription", { fg = "#6e6a86", bg = "NONE" })

				-- Documentation: transparent
				hl("BlinkCmpDoc", { bg = "NONE", fg = "#e0def4" })
				hl("BlinkCmpDocBorder", { bg = "NONE", fg = "#6e6a86" })

				-- Ghost text
				hl("BlinkCmpGhostText", { fg = "#6e6a86", italic = true })

				-- Kind icons: foreground-only, no backgrounds
				hl("BlinkCmpKind", { fg = "#6e6a86" })

				hl("BlinkCmpKindFunction", { fg = "#c4a7e7" })
				hl("BlinkCmpKindMethod", { fg = "#c4a7e7" })
				hl("BlinkCmpKindConstructor", { fg = "#c4a7e7" })

				hl("BlinkCmpKindVariable", { fg = "#9ccfd8" })
				hl("BlinkCmpKindField", { fg = "#9ccfd8" })
				hl("BlinkCmpKindProperty", { fg = "#9ccfd8" })

				hl("BlinkCmpKindClass", { fg = "#f6c177" })
				hl("BlinkCmpKindInterface", { fg = "#f6c177" })
				hl("BlinkCmpKindStruct", { fg = "#f6c177" })
				hl("BlinkCmpKindTypeParameter", { fg = "#f6c177" })

				hl("BlinkCmpKindModule", { fg = "#ea9a97" })

				hl("BlinkCmpKindKeyword", { fg = "#eb6f92" })
				hl("BlinkCmpKindOperator", { fg = "#eb6f92" })

				hl("BlinkCmpKindValue", { fg = "#3e8fb0" })
				hl("BlinkCmpKindConstant", { fg = "#3e8fb0" })
				hl("BlinkCmpKindEnum", { fg = "#3e8fb0" })
				hl("BlinkCmpKindEnumMember", { fg = "#3e8fb0" })

				hl("BlinkCmpKindSnippet", { fg = "#908caa" })

				hl("BlinkCmpKindText", { fg = "#6e6a86" })
				hl("BlinkCmpKindUnit", { fg = "#6e6a86" })
				hl("BlinkCmpKindReference", { fg = "#6e6a86" })

				hl("BlinkCmpKindFile", { fg = "#9ccfd8" })
				hl("BlinkCmpKindFolder", { fg = "#9ccfd8" })

				hl("BlinkCmpKindEvent", { fg = "#ea9a97" })
				hl("BlinkCmpKindColor", { fg = "#c4a7e7" })
			end

			-- Apply now and re-apply on any colorscheme change
			set_blink_highlights()
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = set_blink_highlights,
				desc = "Re-apply blink.cmp highlights",
			})
		end,
	},
}
