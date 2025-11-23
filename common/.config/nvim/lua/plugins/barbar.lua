vim.g.barbar_auto_setup = false

require("barbar").setup({
  icons = {
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true },
      [vim.diagnostic.severity.WARN] = { enabled = true },
      [vim.diagnostic.severity.INFO] = { enabled = true },
      [vim.diagnostic.severity.HINT] = { enabled = false },
    },
    gitsigns = {
      added = { enabled = true },
      deleted = { enabled = true },
      changed = { enabled = true },
    },
  },
})
