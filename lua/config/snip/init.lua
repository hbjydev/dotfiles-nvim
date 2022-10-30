local M = {}

local snippets_folder = vim.fn.stdpath "config" .. "/lua/config/snip/snippets"
local vsc_snippets_folder = vim.fn.stdpath "config" .. "/snippets"

local ls = require "luasnip"
local types = require 'luasnip.util.types'

function M.setup()
  ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = false,
  }

  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load { paths = vsc_snippets_folder }
  require("luasnip.loaders.from_snipmate").lazy_load()
  require("luasnip.loaders.from_lua").lazy_load { paths = snippets_folder }

  vim.cmd [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]

  ls.filetype_extend("all", { "_" })
end

return M
