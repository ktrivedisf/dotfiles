local hasConfigs, configs = pcall(require, "nvim-treesitter.configs")
if hasConfigs then
  configs.setup({
    auto_install = true,
    ensure_installed = {
      "json",
      "lua",
      "markdown",
      "python",
      "vim",
      "vimdoc",
      "yaml",
    },
    ignore_install = {},
    indent = {
      enable = true,
    },
    highlight = {
      enable = true,
    },
    modules = {},
    sync_install = true,
  })
end
