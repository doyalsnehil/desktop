-- pyright server configuration (Neovim 0.11+ convention)
return {
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
				typeCheckingMode = "basic",
			},
		},
	},
}
