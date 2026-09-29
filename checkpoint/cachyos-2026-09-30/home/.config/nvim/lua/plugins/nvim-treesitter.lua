return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			-- Install parsers (async, no-op if already installed)
			require("nvim-treesitter").install({
				"c", "lua", "cpp", "vim", "vimdoc", "python", "c_sharp",
				"javascript", "html", "typescript", "json", "css", "tsx",
				"bash", "http", "sql", "markdown", "markdown_inline", "regex",
			})

			-- Enable treesitter highlighting and indentation for all filetypes
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter-setup", { clear = true }),
				callback = function()
					-- Only start if a parser exists for this filetype
					if pcall(vim.treesitter.start) then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufNewFile" },
		opts = {},
	},
}
