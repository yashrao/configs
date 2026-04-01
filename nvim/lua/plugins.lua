oilconfig = require('oilconfig')
mini_completion_config = require('mini_completion_config')

vim.pack.add {
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/folke/which-key.nvim',
    'https://github.com/nvim-mini/mini.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-lua/plenary.nvim', -- depedency for telescope
    'https://github.com/ej-shafran/compile-mode.nvim',
    'https://github.com/rebelot/kanagawa.nvim.git',
    'https://github.com/rose-pine/neovim',
    'https://github.com/luiscassih/AniMotion.nvim'
}

require('oil').setup(oilconfig)
require('nvim-treesitter').setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    -- find_files = {
    --   find_command = {"fd"},
    -- },
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

require('mini.icons')
require('mini.snippets')
require('mini.completion')
require('mini.trailspace')
require('mini.pairs').setup()
require('mini.completion').setup(mini_completion_config)
require('mini.icons').setup()

local wk = require('which-key')

vim.g.mapleader = " " -- configuring the leaderkey
wk.add({
  -- { "<leader>f", group = "file" }, -- group
  { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
  { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Live Grep", mode = "n" },
  { "<leader>r", "<cmd>Telescope lsp_references<cr>", desc = "Find references", mode = "n" },
  { "<leader>d", "<cmd>Telescope diagnostics<cr>", desc = "Find diagnostics", mode = "n" },
  { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers", mode = "n" },
  -- { "<leader>fn", "<cmd>tabnew<cr>", desc = "New File" },
  { "<leader>k", "<cmd>Compile<cr>", desc = "compile-mode" },
  { "<leader>f1", hidden = true }, -- hide this keymap
  { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
  --{ "<leader>b", group = "buffers", expand = function()
  --    return require("which-key.extras").expand.buf()
  --  end
  --},
  {
    -- Nested mappings are allowed and can be added in any order
    -- Most attributes can be inherited or overridden on any level
    -- There's no limit to the depth of nesting
    mode = { "n", "v" }, -- NORMAL and VISUAL mode
    --{ "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
    { "<leader>w", "<cmd>w<cr>", desc = "Write buffer" },
    { "<leader>x", "<cmd>bd<cr>", desc = "Close buffer" },
    -- { "<leader>c", "<cmd><g-c><cr>", desc = "Toggle Comment" },
  }
})


-- Compile Mode settings 
vim.g.compile_mode = {
    -- The string to show in the compile prompt as a default.
    -- For an empty prompt, you can use:
    -- default_command = "",
    -- To use different defaults based on filetype, you can use a table:
    default_command = {
      python = "python %",
      lua = "lua %",
      javascript = "bun %",
      typescript = "bun %",
      -- c = "cc -o %:r % && ./%:r",
      -- cpp = "cc -std=c++23 -o %:r % && ./%:r",
      java = "javac % && java %:r",
      go = "go run %",
      rust = "cargo run",
    },
    -- A function which returns the default command string is also supported:
    -- default_command = function()
    --   local filetype = vim.bo.filetype
    --   if filetype == "python" then
    --     return "python %"
    --   else
    --     return "make -k "
    --   end
    -- end,
    -- :h compile_mode.default_command
    -- default_command = "make -k ",
    -- Use `baleia` for parsing ANSI escape codes in the output.
    -- :h compile_mode.baleia_setup
    baleia_setup = false,
    -- Expand commands, like `:!` (e.g. `:Compile echo %`)
    -- :h compile_mode.bang_expansion
    bang_expansion = false,
    -- Configure additional entering/leaving directory regexes.
    -- :h compile-mode.directory_change_matchers
    directory_change_matchers = {},
    -- Configure additional error regexes.
    -- :h compile-mode-errors
    error_regexp_table = {},
    -- List of filename regexes to ignore errors from.
    -- :h compile-mode.error_ignore_file_list
    error_ignore_file_list = {},
    -- The minimum error level to jump to.
    -- :h compile-mode.error_threshold
    error_threshold = require("compile-mode").level.WARNING,
    -- Automatically jump to the first error.
    -- :h compile-mode.auto_jump_to_first_error
    auto_jump_to_first_error = false,
    -- How long to highlight an error's location when jumping to it.
    -- :h compile-mode.error_locus_highlight
    error_locus_highlight = 500,
    -- Use Neovim diagnostics instead of opening the compilation buffer.
    -- :h compile-mode.use_diagnostics
    use_diagnostics = false,
    -- Default to calling `:Compile` for `:Recompile`
    -- when there's no previous command.
    -- :h compile-mode.recompile_no_fail
    recompile_no_fail = false,
    -- Ask to save unsaved buffers before compiling.
    -- :h compile-mode.ask_about_save
    ask_about_save = true,
    -- Ask to interrupt already running commands.
    -- :h compile-mode.ask_to_interrupt
    ask_to_interrupt = true,
    -- The name for the compilation buffer.
    -- :h compile-mode.buffer_name
    buffer_name = "*compilation*",
    -- The format for the time information
    -- at the top of the compilation buffer
    -- :h compile-mode.time_format
    time_format = "%a %b %e %H:%M:%S",
    -- List of regexes to hide from the output.
    -- :h compile-mode.hidden_output
    hidden_output = {},
    -- A table of environment variables to pass to commands.
    -- :h compile-mode.environment
    environment = nil,
    -- Clear all environment variables for each command.
    -- :h compile-mode.clear_environment
    clear_environment = false,
    -- Fix compilation for plugins like `nvim-cmp`.
    -- :h compile-mode.input_word_completion
    input_word_completion = false,
    -- Hide the compliation buffer.
    -- :h compile-mode.hidden_buffer
    hidden_buffer = false,
    -- Automatically focus the compilation buffer.
    -- :h compile-mode.focus_compilation_buffer
    focus_compilation_buffer = false,
    -- Automatically move the cursor to the end of the compilation buffer.
    -- :h compile-mode.auto_scroll
    auto_scroll = true,
    -- Jump back past the end/beginning of the errors
    -- with `:NextError`/`:PrevError`
    -- :h compile-mode.use_circular_error_navigation
    use_circular_error_navigation = false,
    -- Print debug information.
    -- :h compile-mode.debug
    debug = false,
    -- Use a pseudo terminal for command execution.
    -- :h compile-mode.use_pseudo_terminal
    use_pseudo_terminal = false,
}

require("AniMotion").setup({
  mode = "helix", -- "nvim" or "helix"
  color = { bg = "#0000ff" }
})
