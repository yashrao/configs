return {
    {
        "yardnsm/nvim-base46",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    { 
        "miikanissi/modus-themes.nvim", 
        priority = 1000 
    }, 
    { 
        "oonamo/ef-themes.nvim" 
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
          -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        lazy = false, -- neo-tree will lazily load itself
        ---@module "neo-tree"
        ---@type neotree.Config?
        opts = {
          -- fill any relevant options here
        },
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
          'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
          'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
          -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
          -- animation = true,
          -- insert_at_start = true,
          -- …etc.
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },
    {
      'lewis6991/gitsigns.nvim',
      opts = {
        on_attach = function(bufnr)
          local gitsigns = require 'gitsigns'

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal { ']c', bang = true }
            else
              gitsigns.nav_hunk 'next'
            end
          end, { desc = 'Jump to next git [c]hange' })

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal { '[c', bang = true }
            else
              gitsigns.nav_hunk 'prev'
            end
          end, { desc = 'Jump to previous git [c]hange' })

          -- Actions
        end,
      },
    },
    {
      'saghen/blink.cmp',
      -- optional: provides snippets for the snippet source
      dependencies = { 'rafamadriz/friendly-snippets' },
    
      -- use a release tag to download pre-built binaries
      version = '1.*',
      -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
      -- build = 'cargo build --release',
      -- If you use nix, you can build from source using latest nightly rust with:
      -- build = 'nix run .#build-plugin',
    
      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = 'super-tab' },
      --keymap = {
      --  -- set to 'none' to disable the 'default' preset
      --  preset = 'default',
      --
      --  ['<Up>'] = { 'select_prev', 'fallback' },
      --  ['<Down>'] = { 'select_next', 'fallback' },
      --
      --  -- disable a keymap from the preset
      --  ['<C-e>'] = {},
      --  
      --  -- show with a list of providers
      --  ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
      --
      --  -- control whether the next command will be run when using a function
      --  ['<C-n>'] = { 
      --    function(cmp)
      --      if some_condition then return end -- runs the next command
      --      return true -- doesn't run the next command
      --    end,
      --    'select_next'
      --  },
      --},

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "lua" }
  },
  opts_extend = { "sources.default" }
},
    {
        -- Main LSP Configuration
        'neovim/nvim-lspconfig',
        dependencies = {
          -- Automatically install LSPs and related tools to stdpath for Neovim
          -- Mason must be loaded before its dependents so we need to set it up here.
          -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
          { 'williamboman/mason.nvim', opts = {} },
          'williamboman/mason-lspconfig.nvim',
          'WhoIsSethDaniel/mason-tool-installer.nvim',

          -- Useful status updates for LSP.
          { 'j-hui/fidget.nvim', opts = {} },

	  'saghen/blink.cmp',
        }
    },
{
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },

  -- example using `opts` for defining servers
  opts = {
    servers = {
      lua_ls = {}
    }
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end

 -- example calling setup directly for each LSP
  --config = function()
  --  local capabilities = require('blink.cmp').get_lsp_capabilities()
  --  local lspconfig = require('lspconfig')

  --  lspconfig['lua_ls'].setup({ capabilities = capabilities })
  --end
},
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
  },

  -- amongst your other plugins
  {'akinsho/toggleterm.nvim', version = "*", config = true}
  -- or
  --{'akinsho/toggleterm.nvim', version = "*", opts = {--[[ things you want to change go here]]}}
}
