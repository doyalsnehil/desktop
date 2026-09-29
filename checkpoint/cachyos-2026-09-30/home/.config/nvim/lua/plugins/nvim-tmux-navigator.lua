return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
	},
	keys = {
		{ "<C-h>", "<cmd>TmuxNavigateLeft<CR>", desc = "Navigate left (tmux/vim)" },
		{ "<C-j>", "<cmd>TmuxNavigateDown<CR>", desc = "Navigate down (tmux/vim)" },
		{ "<C-k>", "<cmd>TmuxNavigateUp<CR>", desc = "Navigate up (tmux/vim)" },
		{ "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate right (tmux/vim)" },
	},
}
