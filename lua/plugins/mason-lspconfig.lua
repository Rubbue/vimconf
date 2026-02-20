-- ~/.config/nvim/lua/plugins/mason-lspconfig.lua
return {
  "williamboman/mason-lspconfig.nvim",
  lazy = false,  -- load at startup
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local mlsp = require("mason-lspconfig")

    -- 1️⃣ Setup Mason LSPConfig
    mlsp.setup({
      ensure_installed = { "clangd" }, -- auto-install clangd
      handlers = {
        function(server_name)
          local opts = { capabilities = capabilities }

          -- 🔧 Custom clangd setup
          if server_name == "clangd" then
            opts.cmd = {
              "clangd",
              "-style={BasedOnStyle: Google, IndentWidth: 4, UseTab: Always, TabWidth: 4}",
              "--fallback-style=Google",
              "--offset-encoding=utf-16",
              "--clang-tidy",
              "--enable-config",
            }
            opts.init_options = {
              fallbackFlags = {
                "-style={BasedOnStyle: Google, IndentWidth: 4, UseTab: Always, TabWidth: 4}",
              },
            }
          end

          -- 🔹 Attach formatting autocmd for all LSPs
          opts.on_attach = function(client, bufnr)
            -- Optional: keep existing on_attach
            if client.server_capabilities.documentFormattingProvider then
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("LspFormat", { clear = false }),
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ async = false, id = client.id })
                end,
              })
            end
          end

          -- Setup the LSP
          lspconfig[server_name].setup(opts)
        end,
      },
    })

    print("✅ Mason-LSPConfig setup complete")
  end,
}

