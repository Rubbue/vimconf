return {
  {
      "L3MON4D3/LuaSnip",
	  dependencies = {
		 "saadparwaiz1/cmp_luasnip",
		 "rafamadriz/friendly-snippets",
	  },
  },
  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path", 
    },
    config = function()
      local cmp = require("cmp")
	  require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)

          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
		  { name = "luasnip"},
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}

