return {
  "airblade/vim-rooter",
  lazy = false,
  init = function()
    vim.g.rooter_manual_only = 0           -- auto root detection (default is fine)
    vim.g.rooter_patterns = {"*.toml",".git","lua", "Makefile", "package.json" }  -- tweak this as needed
    vim.g.rooter_silent_chdir = true       -- don't show messages
    vim.g.rooter_cd_cmd = "lcd"            -- change local dir, not global (use "cd" for global)
  end,
}

