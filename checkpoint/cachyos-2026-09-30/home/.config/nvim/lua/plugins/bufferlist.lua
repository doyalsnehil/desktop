return {
	{
		"EL-MASTOR/bufferlist.nvim",
		lazy = true,
		keys = { { "<Leader>b", desc = "Open bufferlist" } }, -- keymap to load the plugin, it should be the same as keymap.open_bufferlist
		dependencies = "nvim-tree/nvim-web-devicons",
		cmd = "BufferList",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
}
