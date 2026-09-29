return {
	{
		"mason-org/mason.nvim",
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"vtsls",       -- JS/TS (faster than ts_ls)
				"clangd",      -- C/C++
				"pyright",     -- Python
			},
			-- Automatically calls vim.lsp.enable() for installed servers
			automatic_enable = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
	},
}
