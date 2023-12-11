-- maps.lua
local o = vim.o
local wo = vim.wo
local bo = vim.bo
local fn = vim.fn
local execute = vim.api.nvim_command
local cmd = vim.cmd
local set = vim.opt
local map = vim.api.nvim_set_keymap

vim.g.mapleader = [[ ]] -- change the <leader> key to be space
-- o.mapleader = ";"
-- o.maplocalleader = ";"
vim.g.maplocalleader = ';' -- Local leader is semicolon

-- For user defined commands, you’re going to have to go the vim.cmd route:

local cmd = vim.cmd

cmd(':command! WQ wq')
cmd(':command! WQ wq')
cmd(':command! Wq wq')
cmd(':command! Wqa wqa')
cmd(':command! W w')
cmd(':command! Q q')
-- cmd(':command! -bang -nargs=* Sk call fzf#vim#rg_interactive(<q-args>, fzf#vim#with_preview("right:50%:hidden", "alt-h"))')

-- Note that we are using 'vimp' (not 'vim') below to add the maps
-- vimp is shorthand for vimpeccable
local vimp = require('vimp')

local wk = require("which-key")
global tk = require("telekasten")

-- local map = require 'cartographer'

-- Import & assign the map() function from the utils module function M.map(mode, lhs, rhs, opts)
-- local map = require("utils").M.map
function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
--
-- map("n", ",<Space>", ":nohlsearch<CR>", { silent = true })
-- map("n", "<Leader>", ":<C-u>WhichKey ','<CR>" { silent = true })
-- map("n", "<Leader>?", ":WhichKey ','<CR>")
-- map("n", "<Leader>a", ":cclose<CR>")
--
-- `:map` 'gt' in normal mode to searching for symbol references with the LSP
-- map.n.nore.silent.unique['gr'] = '<Cmd>lua vim.lsp.buf.references()<CR>'

local opts = { noremap = true, silent = true }

-- vimp.nnoremap([[<M-r>]], [[:Ranger<Cr>]])
--
---- wbthomason/packer.nvim
-- m.nname("<leader>p", "Packer")
-- vimp.nnoremap([[<leader>pC]], [[:PackerClean<Cr>]])
-- vimp.nnoremap([[<leader>pc]], [[:PackerCompile<Cr>]])
-- vimp.nnoremap([[<leader>pi]], [[:PackerInstall<Cr>]])
-- vimp.nnoremap([[<leader>pu]], [[:PackerUpdate<Cr>]])
-- vimp.nnoremap([[<leader>ps]], [[:PackerSync<Cr>]])
-- vimp.nnoremap([[<leader>pl]], [[:PackerLoad<Cr>]])

-- wk.register({
--    ["<Bslash>"] = {name = "Finding",
--         a = {":Telescope vim_bookmarks all<CR>"},
--         b = {":FzfLua buffers<CR>", "buffers"},
--         ["<Bslash>"] = {":Telescope search_history<CR>"},
--         c = {":FzfLua colorschemes<CR>", "colorschemes"},
--         q = {":<C-U>Cheatsheet<CR>"},
--         e = {":Telescope registers<CR>"},
--         f = { ":Telescope find_files<cr>", "Find File" }, -- create a binding with label
--         g = {":FzfLua grep<CR>"},
--         h = {":Telescope help_tags<CR>"},
--         k = {":FzfLua keymaps<CR>"},
--         l = {":Telescope current_buffer_fuzzy_find<CR>"},
--         m = {":Telescope frecency<CR>"},
--         n = {":FzfLua files cwd=~/sync/pkb<CR>"},
--         o = {":FzfLua loclist"},
--         p = {":FloatermNew clifm<CR>", "clifm, use floaterm"},
--         r = {":Ranger<CR>"},
--         s = {":Startify<CR>"},
--         ["'"] = {":Telescope marks<CR>"},
--         t = {":FzfLua tabs<CR>"},
--         u = { ":FzfLua lines<CR>", "search for lines in all buffers"},
--         y = {":Telescope filetypes<CR>"},
--   } -- end bslash
-- })

vimp.nnoremap({'silent'}, [[<Bslash>"]], ":FzfLua registers<CR>")
vimp.nnoremap({'silent'}, [[<Bslash>']], ":FzfLua marks<CR>")
vimp.nnoremap({'silent'}, [[<Bslash>/]], ":FzfLua search_history/<CR>")
vimp.nnoremap({'silent'}, [[<Bslash>?]], ":FzfLua help_tags<CR>")
vimp.nnoremap({'silent'}, [[<Bslash>\]], ":FzfLua lines<CR>")
vimp.nnoremap({'silent'}, [[<Bslash>b]], ":FzfLua buffers<CR>")
vimp.nnoremap({'silent'}, [[<Bslash>c]], ":FzfLua colorschemes<CR>", "colorschemes")
vimp.nnoremap({'silent'}, [[<Bslash>f]], ":FzfLua files<CR>", "files")
vimp.nnoremap({'silent'}, [[<Bslash>g]], ":FzfLua grep<CR>")
vimp.nnoremap({'silent'}, [[<Bslash>h]], ":FzfLua command_history <CR>")
vimp.nnoremap({'silent'}, [[<Bslash>k]], ":FzfLua keymaps<CR>")
vimp.nnoremap({'silent'}, [[<Bslash>l]], ":FzfLua bLines<CR>")
vimp.nnoremap({'silent'}, [[<Bslash>m]], ":FzfLua oldfiles<CR>")
vimp.nnoremap({'silent'}, [[<Bslash>n]], ":FzfLua files cwd=~/sync/pkb<CR>")
vimp.nnoremap({'silent'}, [[<Bslash>o]], ":FzfLua loclist")
vimp.nnoremap({'silent'}, [[<Bslash>p]], ":FloatermNew clifm<CR>", "floaterm")
vimp.nnoremap({'silent'}, [[<Bslash>r]], ":Ranger<CR>")
vimp.nnoremap({'silent'}, [[<Bslash>s]], ":Startify<CR>")
vimp.nnoremap({'silent'}, [[<Bslash>t]], ":FzfLua tabs<CR>")
vimp.nnoremap({'silent'}, [[<Bslash>u]], ":FzfLua lines<CR>")
vimp.nnoremap({'silent'}, [[<Bslash>y]], ":FzfLua filetypes<CR>")
vimp.nnoremap({silent}, [[<Bslash>w]], ":WebSearchCursor<CR>")
vimp.vnoremap({silent}, [[<Bslash>w]], ":WebSearchVisual<CR>")
-- map("n", "<Bslash>f",":Telescope find_files<CR>")
-- -- map("n", "<Bslash>c",":Telescope colorscheme<CR>")
-- map("n", [[<Bslash>']],":Telescope marks<CR>")
-- -- map("n", "<Bslash>g",":Telescope live_grep<CR>")
-- map("n", "<Bslash>h",":Telescope help_tags<CR>")
-- map("n", "<Bslash>/",":Telescope search_history<CR>")
-- map("n", "<Bslash>b",":Telescope buffers<CR>")
-- map("n", "<Bslash>:",":Telescope commands<CR>")
-- map("n", "<Bslash>y",":Telescope filetypes<CR>")
-- map("n", "<Bslash>l",":Telescope current_buffer_fuzzy_find<CR>")
-- map("n", "<Bslash>m",":Telescope frecency<CR>")
-- -- map("n", "<Bslash>m",":Telescope oldfiles<CR>")
-- map("n", [[<Bslash>"]],":Telescope registers<CR>")
-- map("n", [[<Bslash>a]],":Telescope vim_bookmarks all<CR>")
--
-- -- map("n", [[<Bslash>h]],":HopWord")
-- map("n", [[<Bslash>?]],":<C-U>Cheatsheet<CR>")
-- command! -bang -nargs=* Ag
--   \ call fzf#vim#ag(<q-args>,
--   \", "", " <bang>0 ? fzf#vim#with_preview('up:60%')
--   \", "", "", " : fzf#vim#with_preview('right:50%:hidden', '?'),
--   \", "", " <bang>0)
-- nnoremap("[fzf]ag       :Ag <C-R><C-W><CR>", silent)
-- nnoremap("[fzf]AG       :Ag <C-R><C-A><CR>", silent)
-- xnoremap("[fzf]ag       y:Ag <C-R>"<CR>", silent)

-- inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
vimp.imap("<c-x><c-k>", "<plug>(fzf-complete-word)")
vimp.imap("<c-x><c-f>", "<plug>(fzf-complete-path)")
vimp.inoremap({'expr'}, "<c-x><c-d>", "fzf#vim#complete#path('blsd')")
vimp.imap("<c-x><c-j>", "<plug>(fzf-complete-file-ag)")
vimp.imap("<c-x><c-l>", "<plug>(fzf-complete-line)")

-- rnvimr
-- tnoremap("<A-i>", "<C-\\><C-n>:RnvimrResize<CR>", silent)
-- nnoremap("<A-o>", ":RnvimrToggle<CR>", silent)
-- map('n', "<A-o>", ":RnvimrToggle<CR>", opts)
-- tnoremap("<A-o>", "<C-\\><C-n>:RnvimrToggle<CR>", silent)


-- barbar
-- Move to previous/next
map('n', '<A-,>', ':BufferPrevious<CR>', opts)
map('n', '<A-.>', ':BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
map('n', '<A->>', ' :BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', ':BufferGoto 1<CR>', opts)
map('n', '<A-2>', ':BufferGoto 2<CR>', opts)
map('n', '<A-3>', ':BufferGoto 3<CR>', opts)
map('n', '<A-4>', ':BufferGoto 4<CR>', opts)
map('n', '<A-5>', ':BufferGoto 5<CR>', opts)
map('n', '<A-6>', ':BufferGoto 6<CR>', opts)
map('n', '<A-7>', ':BufferGoto 7<CR>', opts)
map('n', '<A-8>', ':BufferGoto 8<CR>', opts)
map('n', '<A-9>', ':BufferGoto 9<CR>', opts)
map('n', '<A-0>', ':BufferLast<CR>', opts)
-- Close buffer
map('n', '<A-c>', ':BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout<CR>
-- Close commands
--                 :BufferCloseAllButCurrent<CR>
--                 :BufferCloseBuffersLeft<CR>
--                 :BufferCloseBuffersRight<CR>
-- Magic buffer-picking mode
map('n', '<C-p>', ':BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', ':BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', ':BufferOrderByLanguage<CR>', opts)
--
-- -- Other:
-- -- :BarbarEnable - enables barbar (enabled by default)
-- -- :BarbarDisable - very bad command, should never be used
-- --
-- nnoremap("j", "v:count ? 'j' : 'gj'", "expr")
-- nnoremap("k", "v:count ? 'k' : 'gk'", "expr")

-- inoremap("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], "silent", "expr")
-- inoremap("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], "silent", "expr")

-- nmap("<leader>pe", "<Plug>(PickerHelp)", "unique")
-- nmap("<leader>ps", "<Plug>(PickerSplit)", "unique")
-- nmap("<leader>pt", "<Plug>(PickerTabedit", "unique")
-- -- nmap("<leader>pd", "<Plug>(PickerTabdrop)", "unique")
-- nmap("<leader>pv", "<Plug>(PickerVsplit)", "unique")
-- nmap("<leader>pb", "<Plug>(PickerBuffer)", "unique")
-- nmap("<leader>p]", "<Plug>(PickerTag)", "unique")
-- nmap("<leader>pw", "<Plug>(PickerStag)", "unique")
-- nmap("<leader>po", "<Plug>(PickerBufferTag)", "unique")

vim.cmd([[
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

"use control-tab to cycle through buffers, NOT tabs
" :nnoremap <C-Tab> :bnext<CR>
" :nnoremap <S-C-Tab> :bprevious<CR>

" Use CTRL-S for saving, also in Insert mode
noremap  <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>

" Some convenient mappings
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
" inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"


" CTRL-X = cut
" vnoremap <C-X> "*x
" CTRL-C = copy
" vnoremap <C-C> "*y

" copy text to "+ (clipboard)
vmap <Leader>y "+y
" CTRL-R * will insert in the contents of the clipboard
" CTRL-R " (the unnamed register) inserts the last delete or yank.
        " paste text from "+ (clipboard)
" inoremap <Leader>p <ESC>pa
" inoremap <Leader>P <ESC>Pa
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>P "+P
" inoremap <Leader>p <Space><Esc>"+P<Right>xi
" nnoremap <Leader><Leader> V
" only show the current buffer
" noremap <Leader>c :only<CR>

" Surround word with quote
noremap <Leader>' ysiw'
noremap <Leader>" ysiw"

" Add Trailing Semi-colon
" noremap <Leader>; g_a;<Esc>
nnoremap <leader>cc :CaptureClipboard!<CR>
" prepend clips:
nnoremap <leader>cr <Plug>CaptureClipboardReverse!<CR>

" vim-expand-region
    " Hit v to select one character
    " Hit vagain to expand selection to word
    " Hit v again to expand to paragraph
    " Hit <C-v> go back to previous selection if I went too far
" vnoremap v <Plug>(expand_region_expand)
" vnoremap <C-v> <Plug>(expand_region_shrink)

" Alt+leftarrow will go one window left, etc.
nnoremap <silent> <A-Up> :wincmd k<CR>
nnoremap <silent> <A-Down> :wincmd j<CR>
nnoremap <silent> <A-Left> :wincmd h<CR>
nnoremap <silent> <A-Right> :wincmd l<CR>
inoremap <silent> <A-Up> :wincmd k<CR>
inoremap <silent> <A-Down> :wincmd j<CR>
inoremap <silent> <A-Left> :wincmd h<CR>
inoremap <silent> <A-Right> :wincmd l<CR>

let g:picker_custom_find_executable = 'rg'
let g:picker_custom_find_flags = '--color never --files'


" let g:nv_search_paths = ['.', ]
" let g:nv_search_paths = ['~/sync/pkb', ]
let g:nv_default_extension = '.txt'
let g:nv_create_note_window = 'tabedit'
let g:nv_ignore_pattern = ['*.sqlite*', '*_']
" # example for commentary
" nnoremap <space>/ :Commentary<CR>
" vnoremap <space>/ :Commentary<CR>
let g:utl_cfg_hdl_scm_http_system = "silent !firefox -remote 'ping()' && firefox -remote 'openURL( %u )' || firefox '%u#%f' &"

iab <expr> dts strftime("[%Y-%m-%d %a %H:%M]")
nmap <leader>D :put =strftime('[%Y-%m-%d %a %H:%M] <CR>')

nmap <C-a> <Plug>(dial-increment)
nmap <C-x> <Plug>(dial-decrement)
vmap <C-a> <Plug>(dial-increment)
vmap <C-x> <Plug>(dial-decrement)
vmap g<C-a> <Plug>(dial-increment-additional)
vmap g<C-x> <Plug>(dial-decrement-additional)
" paste md link to previous buffer:
nnoremap <leader>l i<c-r>="[" . expand("#") . "]" . "(./" . expand("#") . ")"<cr><esc>

nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
]])
-- vimp.nnoremap('<leader>hw', function()
--   print('hello')
--   print('world')
-- end)

-- -- Toggle line numbers
-- vimp.nnoremap('<leader>n', function()
--   vim.wo.number = not vim.wo.number
-- end)

-- -- Keep the cursor in place while joining lines
-- vimp.nnoremap('J', 'mzJ`z')

vimp.nnoremap('<leader>ev', ':vsplit ~/.config/nvim/init.lua<cr>')
-- -- Or:
-- -- vimp.nnoremap('<leader>ev', [[:vsplit ~/.config/nvim/init.lua<cr>]])
-- -- Or:
-- -- vimp.nnoremap('<leader>ev', function()
-- --   vim.cmd('vsplit ~/.config/nvim/init.lua')
-- -- end)

vim.api.nvim_set_keymap( 'n', '<M-p>', ":lua require'telescope'.extensions.project.project{}<CR>", {noremap = true, silent = true})

require('leap').set_default_keymaps()

vimp.nnoremap ('/', '<Plug>(incsearch-forward)')
vimp.nnoremap ('?', '<Plug>(incsearch-backward)')
vimp.nnoremap ('g/', '<Plug>(incsearch-stay)')

-- Mapping helper
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Using the telescope pickers
--
-- When you are prompted with a telescope picker to select a note or media file, the following mappings apply:
--
--     CTRL + i : inserts a link to the selected note / image
--         the option insert_after_inserting defines if insert mode will be entered after the link is pasted into your current buffer
--     CTRL + y : yanks a link to the selected note / image, ready for pasting
--         the option close_after_yanking defines whether the telescope window should be closed when the link has been yanked
--     RETURN / ENTER : usually opens the selected note or performs the action defined by the called function
--         e.g. insert_img_link()'s action is to insert a link to the selected image.
--

-- setup which-key ---------------------------------------------------------------------
local conf = {
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
    },
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        --     -- this is mostly relevant for key maps that start with a native binding
        --         -- most people should not need to change this
        i = { "j", "k", [[ ]] },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n", -- Normal mode
    -- prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}
wk.setup(conf)

wk.register({
        k = { name = "telekasten", -- optional group name
            a = { ":lua require('telekasten').show_tags()<CR>", "Search thru all tags" },
            b = { ":lua require('telekasten').show_backlinks()<CR>", "Show backlinks" },
            C = { ":CalendarT<CR>", "Open calendar page" },
            c = { ":lua require('telekasten').show_calendar()<CR>", "Open calendar in right split" },
            d = { ":lua require('telekasten').find_daily_notes(dailies_create_nonexisting)<CR>", "Find daily notes" },          
            F = { ":lua require('telekasten').find_friends()<CR>", "Show notes linking to link under cursor" },
            f = { ":lua require('telekasten').find_notes()<CR>", "Find notes by name" },
            g = { ":lua require('telekasten').search_notes()<CR>", "Search notes by content" },              
            I = { ":lua require('telekasten').insert_img_link({ i=true })<CR>", "Browse media and insert link to selected" },
            i = { ":lua require('telekasten').paste_img_and_link()<CR>", "Paste clipboard image, insert link" },
            L = { ":lua require('telekasten').insert_link({ i=true })<CR>", "Browse notes and insert link to selected" },
            m = { ":lua require('telekasten').browse_media()<CR>", "Browse media" },
            n = { ":lua require('telekasten').new_note()<CR>", "Create new note" },
            N = { ":lua require('telekasten').new_templated_note()<CR>", "Create new note, select template" },
            p = { ":lua require('telekasten').preview_img()<CR>", "Preview image under cursor" },
            r = { ":lua require('telekasten').rename_note()<CR>", "Rename current note and update backlinks" }, 
            T = { ":lua require('telekasten').goto_today()<CR>", "Pop today's note" },
            t = { ":lua require('telekasten').toggle_todo()<CR>", "Toggle todo status" },
            w = { ":lua require('telekasten').find_weekly_notes()<CR>", "List weekly notes" },
            W = { ":lua require('telekasten').goto_thisweek()<CR>", "Pop this week's note" },
            y = { ":lua require('telekasten').yank_notelink()<CR>", "Yank link to current note" },
            z = { ":lua require('telekasten').follow_link()<CR>", "Follow link/tag under cursor" },
        },
        p = {name = "Packer",
            C = {':PackerClean<cr>', 'Purge unwanted plugins' },
            c = {':PackerCompile<Cr>'},
            i = {':PackerInstall<Cr>'},
            u = {':PackerUpdate<Cr>'},
            s = {':PackerSync<Cr>', "Install, update, compile all"},
            l = {':PackerLoad<Cr>'},
        },
    }, { prefix = "<leader>" })

        -- vimp.nnoremap({silent}, [[<Bslash>w]], ":WebSearchCursor<CR>")
        -- vimp.vnoremap({silent}, [[<Bslash>w]], ":WebSearchVisual<CR>")
        --     y, ":FzfLua filetypes<CR>")
        --     c",":Telescope colorscheme<CR>")
        --     ?, ":FzfLua help_tags<CR>")
        --     ', ":FzfLua marks<CR>")
        --     ", ":FzfLua registers<CR>")
        --     /, ":FzfLua search_history/<CR>")
        --     g",":Telescope live_grep<CR>"},
        --     h, ":FzfLua command_history <CR>")
        --     l, ":FzfLua bLines<CR>")
        -- map("n", [[<Bslash>h]],":HopWord")
        -- map("n", "<Bslash>m",":Telescope oldfiles<CR>"},
        --     m, ":FzfLua oldfiles<CR>")
        -- : = {":Telescope commands<CR>"},
        --
-- wk.register(lmappings, opts)
-- wk.register(fmappings, opts)

vimp.add_chord_cancellations('n', '<leader>')
