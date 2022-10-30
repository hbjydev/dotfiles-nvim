local function nnoremap(key, call)
  vim.keymap.set('n', key, call, { noremap = true, silent = true })
end

local function inoremap(key, call)
  vim.keymap.set('i', key, call, { noremap = true, silent = true })
end

-- this is going to get theprimeagen cancelled, not me tho hopefully
inoremap("<C-c>", "<Esc>")

-- navigation
nnoremap('<leader>pf', ':Telescope find_files<cr>')
nnoremap('<leader>ps', ':Telescope live_grep<cr>')
nnoremap('<C-p>', ':Telescope git_files<cr>')
nnoremap('<leader>pv', ':NvimTreeToggle<cr>')

-- git stuff
nnoremap("<leader>gco", function () require('neogit').open() end)
nnoremap("<leader>gcc", function () require('neogit').open({ "commit" }) end)

