-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- -- Move to previous/next
-- map("n", "<Leader>b,", "<Cmd>BufferPrevious<CR>", opts)
-- map("n", "<Leader>b.", "<Cmd>BufferNext<CR>", opts)
-- -- Re-order to previous/next
-- map("n", "<Leader>b<", "<Cmd>BufferMovePrevious<CR>", opts)
-- map("n", "<Leader>b>", "<Cmd>BufferMoveNext<CR>", opts)
-- -- Goto buffer in position...
-- map("n", "<Leader>b1", "<Cmd>BufferGoto 1<CR>", opts)
-- map("n", "<Leader>b2", "<Cmd>BufferGoto 2<CR>", opts)
-- map("n", "<Leader>b3", "<Cmd>BufferGoto 3<CR>", opts)
-- map("n", "<Leader>b4", "<Cmd>BufferGoto 4<CR>", opts)
-- map("n", "<Leader>b5", "<Cmd>BufferGoto 5<CR>", opts)
-- map("n", "<Leader>b6", "<Cmd>BufferGoto 6<CR>", opts)
-- map("n", "<Leader>b7", "<Cmd>BufferGoto 7<CR>", opts)
-- map("n", "<Leader>b8", "<Cmd>BufferGoto 8<CR>", opts)
-- map("n", "<Leader>b9", "<Cmd>BufferGoto 9<CR>", opts)
-- map("n", "<Leader>b0", "<Cmd>BufferLast<CR>", opts)
-- -- Pin/unpin buffer
-- map("n", "<Leader>bp", "<Cmd>BufferPin<CR>", opts)
-- -- Close buffer
-- map("n", "<Leader>bc", "<Cmd>BufferClose<CR>", opts)
-- -- Wipeout buffer
-- --                 :BufferWipeout
-- -- Close commands
-- --                 :BufferCloseAllButCurrent
-- --                 :BufferCloseAllButPinned
-- --                 :BufferCloseAllButCurrentOrPinned
-- --                 :BufferCloseBuffersLeft
-- --                 :BufferCloseBuffersRight
-- -- Magic buffer-picking mode
-- map("n", "<Leader>bk", "<Cmd>BufferPick<CR>", opts)
-- -- Sort automatically by...
-- map("n", "<Space>bob", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
-- map("n", "<Space>bod", "<Cmd>BufferOrderByDirectory<CR>", opts)
-- map("n", "<Space>bol", "<Cmd>BufferOrderByLanguage<CR>", opts)
-- map("n", "<Space>bow", "<Cmd>BufferOrderByWindowNumber<CR>", opts)
-- map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- map("n", "<leader>,", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- map("n", "<leader>/", "<cmd>Telescope buffers show_all_buffers=true<cr>", { desc = "Switch Buffer" })
--
-- -- Other:
-- -- :BarbarEnable - enables barbar (enabled by default)
-- -- :BarbarDisable - very bad command, should never be used
-- -- -- Wipeout buffer
-- -- --                 :BufferWipeout<CR>
-- -- -- Close commands
-- -- --                 :BufferCloseAllButCurrent<CR>
-- -- --                 :BufferCloseBuffersLeft<CR>
-- -- --                 :BufferCloseBuffersRight<CR>
-- -- -- Magic buffer-picking mode
-- -- map('n', '<C-p>', ':BufferPick<CR>', opts)
-- -- -- Sort automatically by...
-- -- map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>', opts)
-- -- map('n', '<Space>bd', ':BufferOrderByDirectory<CR>', opts)
-- -- map('n', '<Space>bl', ':BufferOrderByLanguage<CR>', opts)
-- map("n", "gx", "<CMD>execute '!firefox ' .. shellescape(expand('<cfile>'), v:true)<CR>", opts)
-- map("n", "<leader>tg", "<cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>", opts)
