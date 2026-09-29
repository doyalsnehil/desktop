return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local function map(mode, lhs, rhs, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, lhs, rhs, opts)
			end

			map("n", "<leader>ghs", gs.stage_hunk, { desc = "Stage Hunk" })
			map("n", "<leader>ghr", gs.reset_hunk, { desc = "Reset Hunk" })
			map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview Hunk" })
			map("n", "<leader>ghb", gs.blame_line, { desc = "Blame Line" })
			map("n", "<leader>ghd", gs.diffthis, { desc = "Diff This" })
			map("n", "<leader>gH", gs.toggle_deleted, { desc = "Toggle Deleted" })
		end,
	},
}
