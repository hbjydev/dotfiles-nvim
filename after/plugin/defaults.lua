local g = vim.g
local opt = vim.opt

-- remap leader & local leader to <Space>
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = ","
g.vimsyn_embed = "lPr"

opt.termguicolors = true
opt.hlsearch = true
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.signcolumn = "yes"
opt.clipboard = "unnamedplus"
opt.timeoutlen = 300
opt.showmode = false
opt.scrolloff = 8
opt.joinspaces = false
opt.sessionoptions = "buffers,curdir,help,tabpages,winsize,winpos,terminal"
opt.smartindent = true
opt.expandtab = true
opt.textwidth = 0
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.splitbelow = true
opt.splitright = true
opt.laststatus = 3
opt.cmdheight = 1
opt.scrollback = 100000
opt.splitkeep = "screen"

opt.whichwrap:append "<>[]hl"

opt.shortmess:append "sI"

opt.path:remove "/usr/include"
opt.path:append "**"

opt.wildignorecase = true
opt.wildignore:append "**/node_modules/*"
opt.wildignore:append "**/.git/*"

opt.foldlevel = 20
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

g.do_filetype_lua = 1
g.did_load_filetypes = 0
