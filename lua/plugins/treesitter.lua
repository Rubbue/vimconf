return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "c", "cpp", "rust", "python" }, -- languages you want
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}

