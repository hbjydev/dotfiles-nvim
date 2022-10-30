local M = {}

function M.setup(servers, server_options)
  local lspconfig = require "lspconfig"
  local icons = require "config.icons"

  require("mason").setup {
    ui = {
      icons = {
        package_installed = icons.lsp.server_installed,
        package_pending = icons.lsp.server_pending,
        package_uninstalled = icons.lsp.server_uninstalled,
      },
    },
  }

  require("mason-tool-installer").setup {
    ensure_installed = {
      "ansible-language-server",
      "bash-language-server",
      "css-lsp",
      "dockerfile-language-server",
      "eslint-lsp",
      "html-lsp",
      "json-lsp",
      "jsonnet-language-server",
      "lua-language-server",
      "prisma-language-server",
      "tailwindcss-language-server",
      "commitlint",
      "buf",
      "buf-language-server",
      "intelephense",
      "gopls",
      "golangci-lint",
      "gofumpt",
      "golines",
      "gomodifytags",
      "gotests",
      "codelldb",
      "stylua",
      "shfmt",
      "shellcheck",
      "terraform-ls",
      "tflint",
      "typescript-language-server",
      "yaml-language-server",
      "shellcheck",
      "prettierd"
    },
    auto_update = false,
    run_on_start = true,
  }

  require("mason-lspconfig").setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = false,
  }

  require("mason-lspconfig").setup_handlers {
    function(server_name)
      local opts = vim.tbl_deep_extend("force", server_options, servers[server_name] or {})
      lspconfig[server_name].setup(opts)
    end,
    ["sumneko_lua"] = function()
      local opts = vim.tbl_deep_extend("force", server_options, servers["sumneko_lua"] or {})
      require("neodev").setup {}
      lspconfig.sumneko_lua.setup(opts)
    end,
  }
end

return M
