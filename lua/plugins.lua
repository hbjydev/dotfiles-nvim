local M = {}

function M.setup()
  local packer_bootstrap = false

  local conf = {
    profile = {
      enable = true,
      threshold = 0,
    },
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    }
  }

  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end

    local packer_grp = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
    vim.api.nvim_create_autocmd(
      { "BufWritePost" },
      { pattern = "init.lua", command = "source <afile> | PackerCompile", group = packer_grp }
    )
  end

  local function plugins(use)
    -- have packer manage itself
    use { "wbthomason/packer.nvim" }

    -- performance
    use { "lewis6991/impatient.nvim" }

    -- only enable when necessary
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- theming
    use {
      "shaunsingh/nord.nvim",
      config = function()
        vim.cmd.colorscheme [[nord]]
      end,
    }
    use {
      "nvchad/nvim-colorizer.lua",
      cmd = "ColorizerToggle",
      config = function()
        require("colorizer").setup()
      end
    }

    -- git
    use {
      "TimUntersberger/neogit",
      cmd = "Neogit",
      module = 'neogit',
      config = function()
        require("config.neogit").setup()
      end,
    }
    use {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("config.gitsigns").setup()
      end,
    }
    use {
      "akinsho/git-conflict.nvim",
      cmd = {
        "GitConflictChooseTheirs",
        "GitConflictChooseOurs",
        "GitConflictChooseBoth",
        "GitConflictChooseNone",
        "GitConflictNextConflict",
        "GitConflictPrevConflict",
        "GitConflictListQf",
      },
      config = function()
        require("git-conflict").setup()
      end,
    }
    use { "f-person/git-blame.nvim", cmd = { "GitBlameToggle" } }

    -- indentline
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      config = function()
        require("config.indentblankline").setup()
      end,
    }

    use { "mbbill/undotree", cmd = { "UndotreeToggle" } }

    -- better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

    -- status line
    use {
      "nvim-lualine/lualine.nvim",
      config = function()
        require("config.lualine").setup()
      end,
    }

    -- treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
      requires = {
        { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPre" },
        { "windwp/nvim-ts-autotag", event = "InsertEnter" },
        { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPre" },
        { "p00f/nvim-ts-rainbow", event = "BufReadPre" },
        { "RRethy/nvim-treesitter-textsubjects", event = "BufReadPre" },
        { "nvim-treesitter/playground", cmd = { "TSPlaygroundToggle" } },
        { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre", disable = true },
        { "mfussenegger/nvim-treehopper", module = { "tsht" }, disable = true },
        {
          "m-demare/hlargs.nvim",
          config = function()
            require("config.hlargs").setup()
          end,
          disable = false,
        },
        {
          "AckslD/nvim-FeMaco.lua",
          config = function()
            require("femaco").setup()
          end,
          ft = { "markdown" },
          cmd = { "Femaco" },
          module = { "femaco_edit" },
          disable = true,
        },
      },
    }

    -- telescope
    use {
      "nvim-telescope/telescope.nvim",
      opt = true,
      config = function()
        require("config.telescope").setup()
      end,
      cmd = { "Telescope" },
      module = { "telescope", "telescope.builtin" },
      keys = { "<leader>f", "<leader>p", "<leader>z" },
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        "nvim-telescope/telescope-project.nvim",
        "cljoly/telescope-repo.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        { "nvim-telescope/telescope-frecency.nvim", requires = "tami5/sqlite.lua" },
        "nvim-telescope/telescope-dap.nvim",
        {
          "AckslD/nvim-neoclip.lua",
          requires = {
            { "tami5/sqlite.lua", module = "sqlite" },
          },
        },
        "nvim-telescope/telescope-smart-history.nvim",
        {
          "alpha2phi/telescope-arecibo.nvim",
          rocks = { "openssl", "lua-http-parser" },
        },
        "nvim-telescope/telescope-media-files.nvim",
        "dhruvmanila/telescope-bookmarks.nvim",
        "nvim-telescope/telescope-github.nvim",
        "jvgrootveld/telescope-zoxide",
        "Zane-/cder.nvim",
        "nvim-telescope/telescope-symbols.nvim",
        -- "nvim-telescope/telescope-ui-select.nvim",
      },
    }

    -- nvim-tree
    use {
      "kyazdani42/nvim-tree.lua",
      opt = true,
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      config = function()
        require("config.nvimtree").setup()
      end,
    }

    -- buffer line
    use {
      "akinsho/nvim-bufferline.lua",
      event = "BufReadPre",
      config = function()
        require("config.bufferline").setup()
      end,
    }

    use { "onsails/lspkind.nvim" }

    -- autocomplete
    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "lukas-reineke/cmp-rg",
        "davidsierradz/cmp-conventionalcommits",
        {
          "L3MON4D3/LuaSnip",
          config = function()
            require("config.snip").setup()
          end,
        },
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets",
        { "tzachar/cmp-tabnine", run = "./install.sh", disable = true },
      },
    }

    -- auto pairs
    use {
      "windwp/nvim-autopairs",
      opt = true,
      event = "InsertEnter",
      module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
      config = function()
        require("config.autopairs").setup()
      end,
    }

    -- auto tag
    use {
      "windwp/nvim-ts-autotag",
      opt = true,
      event = "InsertEnter",
      config = function()
        require("nvim-ts-autotag").setup { enable = true }
      end,
    }

    -- end wise
    use {
      "RRethy/nvim-treesitter-endwise",
      opt = true,
      event = "InsertEnter",
      disable = false,
    }

    -- lsp
    use {
      "neovim/nvim-lspconfig",
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "folke/neodev.nvim",
        "RRethy/vim-illuminate",
        "jose-elias-alvarez/null-ls.nvim",
        {
          "j-hui/fidget.nvim",
          config = function()
            require("fidget").setup {}
          end,
        },
        "b0o/schemastore.nvim",
        {
          "SmiteshP/nvim-navic",
          config = function()
            require("nvim-navic").setup {}
          end,
          module = { "nvim-navic" },
        },
      },
    }

    -- trouble.nvim
    use {
      "folke/trouble.nvim",
      cmd = { "TroubleToggle", "Trouble" },
      config = function()
        require("trouble").setup {
          use_diagnostic_signs = true,
        }
      end,
    }

    -- Go
    use {
      "ray-x/go.nvim",
      ft = { "go" },
      config = function()
        require("go").setup()
      end,
      disable = false,
    }

    -- performance
    use { "dstein64/vim-startuptime", cmd = "StartupTime" }
    use {
      "nathom/filetype.nvim",
      cond = function()
        return vim.fn.has "nvim-0.8.0" == 0
      end,
    }

    -- sql ls
    use {
      "nanotee/sqls.nvim",
      module = { "sqls" },
      cmd = {
        "SqlsExecuteQuery",
        "SqlsExecuteQueryVertical",
        "SqlsShowDatabases",
        "SqlsShowSchemas",
        "SqlsShowConnections",
        "SqlsSwitchDatabase",
        "SqlsSwitchConnection",
      },
    }

    -- configure packer if it's not already bootstrapped
    if packer_bootstrap then
      print "Neovim restart is required after installation!"
      require("packer").sync()
    end
  end

  packer_init()
  local packer = require "packer"
  pcall(require, "impatient")

  packer.init(conf)
  packer.startup(plugins)
end

return M
