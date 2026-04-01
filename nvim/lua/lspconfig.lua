
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

vim.lsp.config['solidity'] = {
    cmd = { 'nomicfoundation-solidity-language-server', '--stdio' }, 
    filetypes = { 'solidity' },
    root_markets = { '.git', 'foundry.toml' },
    settings = {}
}

vim.lsp.config['go'] = {
    cmd = { 'gopls' },
    filetypes = { 'go' },
    root_markets = { '.git', 'go.mod' },
    settings = {}
}

vim.lsp.config['typescript'] = {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    root_markets = { '.git', 'package.json' },
    settings = {}
}

vim.lsp.config['zig'] = {
    cmd = { 'zls' },
    filetypes = { 'zig' },
    root_markets = { '.git', 'build.zig' },
    settings = {}
}

-- enabling all the lsps
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('clangd')
vim.lsp.enable('solidity')
vim.lsp.enable('go')
vim.lsp.enable('typescript')
