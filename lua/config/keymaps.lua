-- ~/.config/nvim/lua/config/keymaps.lua

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Save file
map("n", "<leader>s", ":w<CR>", opts)

-- Quit
map("n", "<leader>q", ":q<CR>", opts)

-- Exit term 
map("t","<C-t>","<C-\\><C-n>", opts)

-- Enter term
map("n","<leader>ft", "<cmd>ToggleTerm<cr>",opts)

-- Telescope find files
map("n", "<leader>ff", "<cmd>FzfLua files /<cr>", opts)

map("n", "<leader>fb", "<cmd>FzfLua buffers /<cr>",opts)

-- Telescope live grep
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)

-- Lazy open
map("n", "<leader>l", "<cmd>Lazy<cr>", opts)

map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", opts)

map("n", "<leader>fa", function()
  require("fzf-lua").files({
    cwd = os.getenv("HOME"), -- use "/" instead if you prefer absolute root
    fd_opts = "--type f --hidden --follow --exclude .git"
  })
end, { desc = "Find file (global search)" })

-- Code action
map("n","<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>",opts)

-- Goto definition
map("n","gd", "<cmd>lua vim.lsp.buf.definition()<cr>",opts)

-- Hover and def
map('n', 'K', vim.lsp.buf.hover, { desc = "LSP Hover (type + docs)" })
map('n', '<leader>k', vim.lsp.buf.signature_help, { desc = "Function signature help" })

map('n', "<leader>r",vim.lsp.buf.rename, opts)

map("n", "<leader>rn", function()
  vim.lsp.buf.rename()
  -- After renaming, open Trouble references
  vim.defer_fn(function()
    require("trouble").open("lsp_references")
  end, 200)
end, { desc = "Rename symbol and show references" })


-- Show diagnostics
map("n", "<leader>xx", function() require("trouble").toggle() end,
  { desc = "Toggle Trouble (diagnostics)" })

-- Show references for symbol under cursor
map("n", "gr", function() require("trouble").open("lsp_references") end,
  { desc = "Show references in Trouble" })

