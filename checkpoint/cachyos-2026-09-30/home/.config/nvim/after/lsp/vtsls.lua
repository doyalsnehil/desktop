-- vtsls server configuration (Neovim 0.11+ convention)
-- Faster alternative to ts_ls with full workspace context
return {
	settings = {
		typescript = {
			suggest = {
				autoImports = true,
				completeFunctionCalls = true,
			},
			tsserver = {
				maxTsServerMemory = 4096,
			},
			preferences = {
				includePackageJsonAutoImports = "auto",
				preferTypeOnlyAutoImports = true,
				importModuleSpecifier = "project-relative",
			},
			inlayHints = {
				parameterNames = { enabled = "literals" },
				parameterTypes = { enabled = false },
				variableTypes = { enabled = false },
				propertyDeclarationTypes = { enabled = false },
				functionLikeReturnTypes = { enabled = false },
				enumMemberValues = { enabled = false },
			},
		},
		javascript = {
			suggest = {
				autoImports = true,
				completeFunctionCalls = true,
			},
			inlayHints = {
				parameterNames = { enabled = "literals" },
				parameterTypes = { enabled = false },
				variableTypes = { enabled = false },
				propertyDeclarationTypes = { enabled = false },
				functionLikeReturnTypes = { enabled = false },
			},
		},
		vtsls = {
			autoUseWorkspaceTsdk = true,
			experimental = {
				completion = {
					enableServerSideFuzzyMatch = true,
					entriesLimit = 100,
				},
				maxInlayHintLength = 30,
			},
			enableMoveToFileCodeAction = true,
		},
	},
}
