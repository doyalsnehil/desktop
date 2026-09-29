-- Set the leader key to space before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("preferences")
require("keymaps")

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim to manage plugins
require("lazy").setup({
	ui = {
		border = "double",
	},
	spec = {
		{ import = "plugins" },
	},
})

-- Colorscheme and UI tweaks (applied after plugins load)
vim.cmd.colorscheme("rose-pine-moon")
vim.o.cmdheight = 0
vim.o.wrap = false
vim.opt.guicursor = ""
