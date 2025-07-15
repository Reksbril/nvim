-- ~/.config/nvim/init.lua

-- Basic settings
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  -- Catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          -- Disable all previewers to avoid treesitter issues
          preview = false,
          file_ignore_patterns = { "node_modules", ".git/" },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = false,
          },
          live_grep = {
            theme = "dropdown",
            previewer = false,
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
          },
        },
      })
      
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>f", builtin.find_files)
      vim.keymap.set("n", "<leader>g", builtin.live_grep)
      vim.keymap.set("n", "<leader>b", builtin.buffers)
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local status_ok, configs = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        return
      end
      
      configs.setup({
        ensure_installed = { "lua", "vim", "javascript", "python", "html", "css" },
        sync_install = false,
        auto_install = true,
        highlight = { 
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },

  -- GitSigns
  {
    "lewis6991/gitsigns.nvim"
  },
})

-- Key mappings
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
