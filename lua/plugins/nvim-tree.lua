return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        -- ✅ Restore default keymaps
        api.config.mappings.default_on_attach(bufnr)

        local function opts(desc)
          return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end

        -- Set current node as new root
        vim.keymap.set("n", "gr", api.tree.change_root_to_node, opts("Set Root to Node"))

        -- Open ToggleTerm in selected node's directory
        vim.keymap.set("n", "<leader>tt", function()
          local node = api.tree.get_node_under_cursor()
          local path = node.absolute_path or node.link_to or node.name
          local dir = vim.fn.isdirectory(path) == 1 and path or vim.fn.fnamemodify(path, ":h")

          require("toggleterm.terminal").Terminal:new {
            dir = dir,
            direction = "horizontal", -- or "vertical" / "float"
            close_on_exit = false,
            hidden = true,
          }:toggle()
        end, opts("Open ToggleTerm in Node Directory"))
      end,
    }
  end,
}
