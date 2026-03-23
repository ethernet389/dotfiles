-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      url = "https://github.com/catppuccin/nvim",
      name = "catppuccin",
      priority = 1000
    },

    {
      url = "https://tpope.io/vim/fugitive.git",
      name = "git-wrapper"
    },

    {
      url = "https://github.com/mason-org/mason.nvim",
      name = "mason",
      build = ":MasonUpdate",
      opts = {}
    },

    {
      url = "https://github.com/neovim/nvim-lspconfig",
      name = "lspconfig"
    },

    {
      url = "https://github.com/mason-org/mason-lspconfig.nvim",
      name = "mason-lspconfig",

      dependencies = {
	"mason",
	"lspconfig",
      },

      opts = {
	"awk_ls",
	"bash_ls",
	"clangd",
	"lua_ls",
	"pyright",
	"markdown_oxide"
      }
    },

    {
      url = "https://github.com/nvim-treesitter/nvim-treesitter",
      name = "treesitter",
      lazy = false,
      build = ":TSUpdate"
    },
  }
})


-- Setup LSP bindings
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    local opts = { buffer = bufnr }

    -- Mappings
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)		     -- Go to definition
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)			     -- Hover
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)		     -- Go to implementation
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)		     -- Go to references
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)		     -- Rename
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts) -- Actions

    -- Diagnostic
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)	       -- Previous error
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)	       -- Next error
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)   -- Show error in floating window

    if client:supports_method('textDocument/formatting') then
      vim.keymap.set('n', '<space>f', function()
	vim.lsp.buf.format({ async = true })
      end, opts)
    end
  end,
})


-- Preferences
vim.cmd.colorscheme "catppuccin-mocha"

vim.g.syntax_on = true
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.clipboard = "unnamedplus"

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.expandtab = false
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4

vim.opt.list = true
vim.opt.listchars = "tab:|-"
