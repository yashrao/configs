
vim.lsp.config['rust_analyzer'] = {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' }, 
    root_markers = { '.git', 'Cargo.toml' },
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
        }
    }
}

vim.lsp.config['clangd'] = {
    cmd = { 'clangd' }, 
    filetypes = { 'c', 'cpp' },
    root_markets = { '.git', 'Makefile' },
    settings = {}
}

-- vim.lsp.config['clangd'] = {
--     cmd = { 'clangd' }, 
--     filetypes = { 'c', 'cpp' },
--     root_markets = { '.git', 'Makefile' },
--     settings = {}
-- }

-- enabling all the lsps
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('clangd')

