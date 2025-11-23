-- Disable netrw for nvim-tree support
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = false,
  },
  renderer = {
    highlight_opened_files = "icon",
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
      },
    },
    indent_markers = {
      enable = true,
    },
  },
  respect_buf_cwd = true,
  sync_root_with_cwd = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
})
