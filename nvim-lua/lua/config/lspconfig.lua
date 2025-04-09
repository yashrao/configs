
local lspconfig = require("lspconfig")

local servers = { "html", "cssls", "ccls", "gopls", "ts_ls", "ruff" }

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))

capabilities = vim.tbl_deep_extend('force', capabilities, {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
  }
})

-- Define on_attach for keybindings
--local on_attach = function(client, bufnr)
--  local opts = { buffer = bufnr, noremap = true, silent = true }
--  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)        -- Go to definition
--  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)              -- Show hover info
--  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)    -- Rename symbol
--  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code actions
--end
--local servers = {
--     clangd = {},
--     gopls = {},
--     --pyright = {},
--     rust_analyzer = {},
--    -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
--    --
--    -- Some languages (like typescript) have entire language plugins that can be useful:
--    --    https://github.com/pmizio/typescript-tools.nvim
--    --
--    -- But for many setups, the LSP (`ts_ls`) will work just fine
--    ts_ls = {},
--
--    lua_ls = {
--      -- cmd = { ... },
--      -- filetypes = { ... },
--      -- capabilities = {},
--      settings = {
--        Lua = {
--          completion = {
--            callSnippet = 'Replace',
--          },
--          -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
--          -- diagnostics = { disable = { 'missing-fields' } },
--        },
--      },
--    },
--}


-- lsps with default config
--for _, lsp in ipairs(servers) do
--  lspconfig[lsp].setup {
--    on_attach = on_attach,
--    --on_init = lspconfig.on_init,
--    capabilities = capabilities,
--  }
--end

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities
    }
end

---- lsps with default config
--for _, lsp in ipairs(servers) do
--  lspconfig[lsp].setup {
--    on_attach = nvlsp.on_attach,
--    on_init = nvlsp.on_init,
--    capabilities = nvlsp.capabilities,
--  }
--end
--
-- configuring single server, example: typescript
--lspconfig.ts_ls.setup {
--  on_attach = lspconfig["ts_ls"].on_attach,
--  on_init = lspconfig["ts_ls"].on_init,
--  capabilities = lspconfig["ts_ls"].capabilities,
--}

lspconfig.rust_analyzer.setup({
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
            inlayHints = {
              typeHints = { enable = false },
              parameterHints = { enable = false },
              chainingHints = { enable = false },
              closureReturnTypeHints = { enable = false },
              lifetimeElisionHints = { enable = false },
              bindingModeHints = { enable = false },
              closingBraceHints = { enable = false },
            },
        }
    }
})
