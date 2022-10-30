local M = {}

local keymap = vim.keymap.set

local function keymappings(client, bufnr)
  local opts = { noremap = true, silent = true }

  -- Key mappings
  keymap("n", "K", vim.lsp.buf.hover, { buffer = bufnr })

  keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
  keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)

  keymap("n", "<leader>R", "<cmd>Trouble lsp_references<cr>", opts)
  keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  keymap("n", "<leader>d", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", opts)
  keymap("n", "<leader>r", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
  keymap("n", "<leader>s", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", opts)
  keymap("n", "<leader>t", "<cmd>TroubleToggle document_diagnostics<cr>", opts)

  if client.server_capabilities.documentFormattingProvider then
    keymap("n", "<leader>F", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
  end

  keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
  keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
  keymap("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
  keymap("n", "gI", "<cmd>Telescope lsp_implementations<cr>", opts)
  keymap("n", "gb", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)

  keymap("v", "<leader>a", "<cmd>'<,'>lua vim.lsp.buf.code_action()<CR>", opts)
end

function M.setup(client, bufnr)
  keymappings(client, bufnr)
end

return M
