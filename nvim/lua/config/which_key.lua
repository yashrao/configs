local wk = require("which-key")
wk.add({
  { "<leader>f", group = "file" }, -- group
  { "<leader>e", "<cmd>Neotree<cr>", desc = "File Tree", mode = "n" },
  { "<leader>t", "<cmd>ToggleTerm<cr>", desc = "ToggleTerm", mode = "n" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep", mode = "n" },
  { "<leader>gr", "<cmd>Telescope lsp_references<cr>", desc = "Find references", mode = "n" },
  { "<leader>gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Find definitions", mode = "n" },
  { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers", mode = "n" },
  { "<leader>fn", "<cmd>tabnew<cr>", desc = "New File" },
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
  }
})
