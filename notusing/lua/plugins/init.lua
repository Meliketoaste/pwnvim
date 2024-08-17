local conf_path = vim.fn.stdpath "config" --[[@as string]]

local plugins = {
  -- colorschemes
  {
    "catppuccin/nvim",
    lazy = true,
    priority = 1000,
    name = "catppuccin",
    init = function()
      vim.cmd.colorscheme "catppuccin"
    end,
    config = function()
      local opts = require "plugins.colorscheme"
      require("catppuccin").setup(opts)
    end,
  },

  --- Mini stuffs
  {
    "echasnovski/mini.nvim",
    name = "mini",
    version = false,
    keys = {
      { "<leader>e", mode = "n" },
      { "<leader>ff", mode = "n" },
      { "<leader>b", mode = "n" },
      { "<leader>fr", mode = "n" },
      { "<leader>fw", mode = "n" },
      { "<leader>q", mode = "n" },
      { "<leader>ti", mode = "n" },
      { "<C-q>", mode = "n" },
      { "gcc", mode = "n" },
      { "<leader>", mode = "n" },
      { "gc", mode = "n" },
      { "gc", mode = "x" },
      { "H", mode = "x" },
      { "J", mode = "x" },
      { "K", mode = "x" },
      { "L", mode = "x" },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        package.loaded["nvim-web-devicons"] = {}
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    event = function()
      if vim.fn.argc() == 0 then
        return "VimEnter"
      else
        return { "InsertEnter", "LspAttach" }
      end
    end,

    config = function()
      local mini_config = require "plugins.mini_nvim"
      local mini_modules = {
        "icons",
        "comment",
        "starter",
        "pairs",
        "ai",
        "surround",
        "files",
        "hipatterns",
        "bufremove",
        "pick",
        "move",
        "indentscope",
        "extra",
        "visits",
        "clue",
        "notify",
        "git",
        "diff",
      }
      require("core.mappings").mini()
      for _, module in ipairs(mini_modules) do
        require("mini." .. module).setup(mini_config[module])
      end
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    event = {
      "BufReadPost",
      "BufNewFile",
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "lua", "vimdoc", "rust", "go" },
        highlight = {
          enable = true,
          use_languagetree = true,
        },

        indent = { enable = true },
      }
    end,
  },

  --- Completion menu stuffs
  {
    "hrsh7th/nvim-cmp",
    name = "cmp",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "https://codeberg.org/FelipeLema/cmp-async-path",
    },
    event = { "LspAttach", "InsertCharPre" },
    config = function()
      require "plugins.cmp"
    end,
  },

  {
    "Bekaboo/dropbar.nvim",
    name = "dropbar",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("dropbar").setup()
    end,
  },

  --- lsp stuffs
  {
    "neovim/nvim-lspconfig",
    name = "lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require "plugins.lsp"
      require("core.mappings").lsp()
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    name = "markdown",
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    config = function()
      require("render-markdown").setup {}
    end,
  },

  {
    name = "options",
    event = "VeryLazy",
    dir = conf_path,
    config = function()
      require("core.opts").final()
      require("core.mappings").general()
      require("core.mappings").misc()
      require("core.utils").autocmds()
    end,
  },
}

require("lazy").setup(plugins, require "plugins.lazy_nvim")
