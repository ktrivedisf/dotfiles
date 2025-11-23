require("mason").setup({
  npm = {
    use_pnpm = true,
  },
  pip = {
    use_python3_host_prog = true,
  },
  ui = {
    border = "rounded",
  },
})

require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "lua_ls",
  },
})

-- Configure LSP servers
require("mason-null-ls").setup({
  ensure_installed = {
    "stylua",
  },
  handlers = {},
})

-- null-ls
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.mypy,
  },
})

-- Setup all available servers
require("lsp-auto-setup").setup({
  settings = {},
})

-- Show diagnostic information on the current line as virtual text
vim.diagnostic.config({
  float = { border = "rounded", source = "if_many" },
  severity_sort = true,
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  } or {},
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = {
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
    source = "if_many",
    spacing = 2,
  },
})

-- Enable inlay hints
vim.lsp.inlay_hint.enable(true)
