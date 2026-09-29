-- lua_ls server configuration (Neovim 0.11+ convention)
-- This file is auto-discovered by vim.lsp.config() from after/lsp/
return {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}
