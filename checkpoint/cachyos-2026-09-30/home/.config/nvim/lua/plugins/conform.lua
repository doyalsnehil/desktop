return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			json = { "prettier" },
			markdown = { "prettier" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			python = { "black" },
			sql = { "sql_formatter" },
		},
		formatters = {
			["clang-format"] = {
				prepend_args = { "--style=file" },
			},
		},
	},
}
