-- vi: foldmethod=marker
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Plugin setup with lazy.nvim
require("lazy").setup({
  -- Utility Library
  {"nvim-lua/plenary.nvim"},
  { "junegunn/fzf.vim" },
  { "raimondi/delimitmate" },
  -- Syntax Highlighting
  { "nvim-treesitter/nvim-treesitter",
     build = ":TSUpdate",
     config = function()
      require("plugins.treesitter")
    end,
  },
  { "tpope/vim-fugitive" },
  { "sindrets/diffview.nvim" },

  -- LSP and Completion {{{
  {
      "williamboman/mason.nvim",
      build = ":MasonUpdate",
      cmd = { "Mason", "MasonInstall", "MasonUpdate" }, -- ensures :Mason auto-loads
      opts = {},  -- mason defaults are fine
      dependencies = { "neovim/nvim-lspconfig" },
  },
  { "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",         -- LSP server installer
      "williamboman/mason-lspconfig.nvim",
    }
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "jdtls",
        -- optional Java extras:
        -- "java-debug-adapter", "java-test"
      },
      auto_update = false,
      run_on_start = true,
    },
  },
  -- Mason <-> lspconfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
  },
  { "mfussenegger/nvim-jdtls" , ft = "java"},
  --{
  --  "mason-org/mason.nvim",
  --  branch = "feats",
  --  build = ":MasonUpdate",
  --  config = function()
  --    require("plugins.mason")
  --  end,
  --  dependencies = { "neovim/nvim-lspconfig" },
  --},
  --{
  --  "mason-org/mason-lspconfig.nvim",
  --  dependencies = { "mason-org/mason.nvim" },
  --},
  { "nvimtools/none-ls.nvim" },
  { "jay-babu/mason-null-ls.nvim" },
  {
    "massolari/lsp-auto-setup.nvim",
    dependencies = { "mason-org/mason.nvim" },
    config = true,
    opts = {
      stop_unused_server = {
        enable = true,
      },
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("plugins.blink")
    end,
    version = "1.x",
  },
  -- }}}
  -- Other code plugins {{{
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("plugins.lsp-signature")
    end,
  },
  { "tpope/vim-commentary" },
  { "darfink/vim-plist" },
  {
    "folke/trouble.nvim",
    config = function()
      require("plugins.trouble")
    end,
  },
  {
    "filipdutescu/renamer.nvim",
    config = function()
      require("plugins.renamer")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "wintermute-cell/gitignore.nvim",
    config = function()
      require("gitignore")
    end,
  },
  -- }}}
  -- Autocompletion
  { "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    }
  },

    -- Utilities {{{
  { "kana/vim-repeat" },
  { "anyakichi/vim-surround" },
  { "junegunn/vim-easy-align" },
  {
    "ntpeters/vim-better-whitespace",
    config = function()
      require("plugins.better-whitespace")
    end,
  },
  { "gisphm/vim-gitignore" },
  { "dstein64/vim-startuptime" },
  { "osyo-manga/vim-anzu" },

  -- File Explorer
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },

  -- Fuzzy Finder
  { "nvim-telescope/telescope.nvim",
     dependencies = {
         "nvim-lua/plenary.nvim" ,
          "nvim-telescope/telescope-ui-select.nvim",
     },
     config = function()
     require("plugins.telescope")
    end,
  },

  { "christoomey/vim-sort-motion" },
  { "mbbill/undotree" },
  { "iamyoki/buffer-reopen.nvim" },


  -- Statusline
  {"nvim-lualine/lualine.nvim"},

  -- Key Binding Helper
  {"folke/which-key.nvim"},

  -- Colorscheme (customize as desired)
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- Colorscheme
  { "sonph/onehalf",
    config = function(plugin)
    vim.opt.rtp:append(plugin.dir .. "/vim")
    vim.cmd("colorscheme onehalfdark")
    end,
  lazy = false,       -- (recommended) load at startup for colorscheme
  priority = 1000,    -- (recommended) load before all others
  },

  -- multi cursor : vim-visual-multi
  {
    "mg979/vim-visual-multi",
    branch = "master"
  },
    { "nvim-tree/nvim-web-devicons" },
  { "onsails/lspkind.nvim" },
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("plugins.nvim-tree")
    end,
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require("plugins.illuminate")
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("plugins.rainbow-delimiters")
    end,
  },
  {
    "romgrk/barbar.nvim",
    config = function()
      require("plugins.barbar")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.indent-blankline")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require("plugins.fidget")
    end,
  },
  {
    "kosayoda/nvim-lightbulb",
    config = function()
      require("plugins.lightbulb")
    end,
  },
  -- }}}

  -- Local {{{
  pcall(require, "config.lazy-local") and { import = "config.lazy-local" } or nil,
  -- }}}
})

