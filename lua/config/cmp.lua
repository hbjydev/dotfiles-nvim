local M = {}

vim.o.completeopt = "menu,menuone,noselect"

local types = require "cmp.types"
local compare = require "cmp.config.compare"
local lspkind = require "lspkind"

local source_mapping = {
  nvim_lsp = "[Lsp]",
  luasnip = "[Snip]",
  buffer = "[Buffer]",
  nvim_lua = "[Lua]",
  treesitter = "[Tree]",
  path = "[Path]",
  rg = "[Rg]",
  nvim_lsp_signature_help = "[Sig]",
}

function M.setup()
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
  end

  local luasnip = require "luasnip"
  local cmp = require "cmp"

  cmp.setup {
    completion = { completeopt = "menu,menuone,noinsert", keyword_length = 1 },

    sorting = {
      priority_weight = 2,
      comparators = {
        compare.score,
        compare.recently_used,
        compare.offset,
        compare.exact,
        compare.kind,
        compare.sort_text,
        compare.length,
        compare.order,
      },
    },

    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },

    formatting = {
      format = lspkind.cmp_format {
        mode = "symbol_text",
        maxwidth = 40,

        before = function(entry, vim_item)
          vim_item.kind = lspkind.presets.default[vim_item.kind]

          local menu = source_mapping[entry.source.name]
          vim_item.menu = menu
          return vim_item
        end,
      },
    },

    mapping = cmp.mapping.preset.insert({
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      ["<C-u>"] = cmp.mapping.scroll_docs(-4),
      ["<C-d>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
    }),

    sources = {
      { name = "nvim_lsp", max_item_count = 15 },
      { name = "nvim_lsp_signature_help", max_item_count = 5 },
      { name = "treesitter", max_item_count = 5 },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "calc" },
    },

    window = {
      documentation = {
        border = { "???", "???", "???", "???", "???", "???", "???", "???" },
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
      },
    },
  }

  -- Auto pairs
  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
end

return M
