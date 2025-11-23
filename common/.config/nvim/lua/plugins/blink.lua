require("blink.cmp").setup({
  completion = { documentation = { auto_show = true } },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  keymap = {
    preset = "enter", -- <Enter> confirms by default
    ["<Tab>"] = { "accept", "fallback" }, -- Tab confirms the completion selection
    ["<S-Tab>"] = { "select_prev", "fallback" }, -- Shift+Tab selects previous entry
    ["<D-Space>"] = { "show", "fallback" }, -- Ctrl+Space triggers autocomplete menu
    ["<C-Space>"] = false,
    -- ["<Esc>"] = { "cancel", "fallback" }, -- Esc closes the completion menu
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
})
