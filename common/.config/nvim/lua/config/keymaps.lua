-- Emacs-style Insert Mode Keybindings
vim.keymap.set('i', '<C-a>', '<Home>', { noremap = true })       -- beginning of the line
vim.keymap.set('i', '<C-e>', '<End>', { noremap = true })        -- end of the line
vim.keymap.set('i', '<C-n>', '<Down>', { noremap = true })       -- next line
vim.keymap.set('i', '<C-p>', '<Up>', { noremap = true })         -- previous line
vim.keymap.set('i', '<C-k>', '<End><C-o>d$', { noremap = true }) -- yank the line after cursor
vim.keymap.set('i', '<C-x>u', '<C-o>u', { noremap = true })      -- undo
-- vim.keymap.set('i', '<C-Space>', '<C-o>V', { noremap = true })   -- multi-line selection
vim.keymap.set('i', '<C-Space>', '<Esc>v', { noremap = true, silent = true })
vim.keymap.set('x', '<C-n>', 'Vj', { noremap = true, silent = true })

vim.keymap.set('i', '<C-y>', '<C-o>p', { noremap = true, silent = true})       -- paste the line which you had cut
vim.keymap.set('i', '<C-k>', '<C-o>d$', { noremap = true })      -- yank line after cursor (again)
vim.keymap.set('i', '<C-s>', '<Esc>/', { noremap = true })       -- Search with Ctrl-s
vim.keymap.set("i", "<C-b>", "<Left>")
vim.keymap.set("i", "<C-f>", "<Right>")
vim.keymap.set('i', '<C-w><C-s>', '<Esc>:w<CR>gi', { noremap = true, silent = true })


vim.keymap.set({'v'}, '<C-c>', '"+y')                            -- Command-C -> copy
vim.keymap.set({'n', 'v', 'x'}, '<D-c>', '"+y', { desc = 'MacOS copy' })
vim.keymap.set("n", "<C-e>", "$")

-- Visual Mode Keybinding
-- delete selection with Ctrl-k and go back to insert mode
vim.keymap.set('x', '<C-k>', function()
  vim.cmd('normal! d')
  vim.api.nvim_feedkeys('i', 'n', true)
end, { noremap = true, silent = true })

-- vim-multi-cursor remapping
vim.keymap.set({ 'n', 'x' }, '<C-j>', '<Plug>(VM-Add-Cursor-Down)', { remap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<C-k>', '<Plug>(VM-Add-Cursor-Up)',   { remap = true, silent = true })

vim.g.VM_maps = {
  ["Find Under"] = "<C-n>",
  ["Find Subword Under"] = "<C-d>", -- acts on partial selection
}

-- Optional: Quick keymap to toggle the file explorer with <leader>e
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- Show callers
vim.keymap.set("n", "<leader>fr", function()
  require("telescope.builtin").lsp_references()
end, { desc = "Show callers" })

-- Toggle warnings/diagnostics for java/python
vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.config({virtual_text = not vim.diagnostic.config().virtual_text})
end)


-- Code Actions
vim.keymap.set("n", "<D-.>", vim.lsp.buf.code_action, { desc = "Show code actions" })

-- trouble.nvim
vim.keymap.set("n", "<F8>", "<ESC>:Trouble diagnostics toggle<CR>", { desc = "Toggle diagnostics" })
vim.keymap.set(
  "i",
  "<F8>",
  "<ESC>:Trouble diagnostics toggle<CR>a",
  { desc = "Toggle diagnostics" }
)

-- Move lines using Alt+[jk]
--vim.keymap.set("n", "<M-j>", "mz:m+<cr>`z", { desc = "Move line down" })
--vim.keymap.set("n", "<M-k>", "mz:m-2<cr>`z", { desc = "Move line up" })
--vim.keymap.set("v", "<M-j>", ":m'>+<cr>`<my`>mzgv`yo`z", { desc = "Move selection down" })
--vim.keymap.set("v", "<M-k>", ":m'<-2<cr>`>my`<mzgv`yo`z", { desc = "Move selection up" })

-- Tab & Shift+Tab in visual mode
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent selection" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Unindent selection" })

-- vim-fugitive
vim.keymap.set("n", "gh", ":diffget //2<CR>", { desc = "Get left diff" })
vim.keymap.set("n", "gl", ":diffget //3<CR>", { desc = "Get right diff" })

