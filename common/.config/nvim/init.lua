
require("config.lazy")
require("config.keymaps")
require("config.options")
require("config.autocommands")
-- Initialize nvim-tree *after* plugins are loaded
-- require("nvim-tree").setup()
-- require("mason").setup()
-- require("mason-lspconfig").setup()

-- java language server
--vim.lsp.config['jdtls'] = {
--  cmd = { 'jdtls' },
--  filetypes = { 'java' },
--  root_markers = {'.git', 'pom.xml', 'build.gradle'},
--  -- other config options as needed (see Mason/LSP docs for more advanced setup)
--}
--vim.lsp.enable('jdtls')



-- Set colorscheme after plugins are loaded

-- vim.cmd [[colorscheme onehalf]]


