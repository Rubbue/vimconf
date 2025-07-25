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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Diagnostics
vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- could also be "■", "▎", "", etc.
  },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})

if vim.loop.os_uname().sysname == "Darwin" then
  require("config.mac")
end


-- Tabs
vim.opt.expandtab = false      -- Use actual tab characters
vim.opt.tabstop = 4            -- Display width of a tab character
vim.opt.shiftwidth = 4         -- Indent amount when using >>, <<
vim.opt.softtabstop = 4        -- How many spaces a <Tab> feels like


-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})


vim.cmd("colorscheme tokyonight-night")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "markdown_inline" },
  callback = function()
    pcall(vim.treesitter.start, 0, "markdown")
    pcall(vim.treesitter.start, 0, "markdown_inline")
  end,
})


vim.opt.number = true            -- Shows the absolute number on the current line
vim.opt.relativenumber = true    -- Shows relative numbers on other lines

