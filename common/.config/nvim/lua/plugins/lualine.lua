require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = require("lualine.themes.onedark"),
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
    }
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = {
      {
        function()
          return vim.opt.paste:get() and "PASTE MODE" or ""
        end,
        color = { fg = "white", gui = "bold" },
      },
      "encoding",
      "fileformat",
      "filetype",
    },
    lualine_y = {},
    lualine_z = { "location" }
  },
})

require("lualine").hide({
  place = { "tabline" },
  unhide = false,
})
