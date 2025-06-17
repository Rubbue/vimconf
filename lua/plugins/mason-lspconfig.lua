return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig","hrsh7th/cmp-nvim-lsp",},
  config = function()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
    require('mason-lspconfig').setup({	
		handlers = {
			function(server_name)
				require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
			end
		},
	})
  end,
}

