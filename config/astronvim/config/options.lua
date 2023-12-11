-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.wrap = true
opt.textwidth = 0
opt.linebreak = true
opt.backspace = "indent,eol,start" -- Backspace for dummies
opt.whichwrap = "b,s,<,>,[,]"

if vim.g.neovide then
	vim.o.guifont = "Input:h12" -- text below applies for VimScript
end
--
