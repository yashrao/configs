vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

-- Set background and enable true colors
vim.o.background = 'dark'
vim.o.termguicolors = true

-- Define color palette
local colors = {
  fg1 = '#b0b0b0',
  fg2 = '#a2a2a2',
  fg3 = '#949494',
  fg4 = '#868686',
  fg6 = '#c3c3c3',
  bg1 = '#000000',
  bg2 = '#271414',
  bg3 = '#3a2929',
  bg4 = '#4c3d3d',
  builtin = '#c97f6f',
  -- keyword = '#ffffff',
  keyword = '#59c2ff',
  const = '#7ad0c6',
  comment = '#44b340',
  func = '#c1d1e3',
  str = '#2ec09c',
  type = '#8cde94',
  -- type = '#59c2ff',
  var = '#c1d1e3',
  selection = '#0000ff',
  warning = '#ff0000',
  warning2 = '#ff8800',
}

-- Set highlight groups
vim.api.nvim_set_hl(0, 'Normal', { bg = colors.bg1, fg = colors.fg1 })
vim.api.nvim_set_hl(0, 'Comment', { fg = colors.comment })
vim.api.nvim_set_hl(0, 'String', { fg = colors.str })
-- vim.api.nvim_set_hl(0, 'Keyword', { fg = colors.keyword, bold = true })
vim.api.nvim_set_hl(0, 'Keyword', { fg = colors.keyword, bold = false })
vim.api.nvim_set_hl(0, 'Function', { fg = colors.func })
vim.api.nvim_set_hl(0, 'Identifier', { fg = colors.var })
vim.api.nvim_set_hl(0, 'Type', { fg = colors.type })
vim.api.nvim_set_hl(0, 'Constant', { fg = colors.const })
vim.api.nvim_set_hl(0, 'Special', { fg = colors.builtin })
vim.api.nvim_set_hl(0, 'Visual', { bg = colors.selection })
vim.api.nvim_set_hl(0, 'Cursor', { bg = colors.fg4 })
vim.api.nvim_set_hl(0, 'CursorLine', { bg = colors.bg2 })
vim.api.nvim_set_hl(0, 'StatusLine', { bg = colors.bg2, fg = colors.fg4, bold = true })
vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = colors.bg1, fg = colors.var })
vim.api.nvim_set_hl(0, 'VertSplit', { fg = colors.fg3 })
vim.api.nvim_set_hl(0, 'LineNr', { fg = colors.fg4, bg = colors.bg1 })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = colors.fg6, bg = colors.bg2, bold = true })
vim.api.nvim_set_hl(0, 'IncSearch', { fg = colors.warning, bg = colors.bg3, bold = true })
vim.api.nvim_set_hl(0, 'Search', { fg = colors.fg2, bg = colors.bg3 })
vim.api.nvim_set_hl(0, 'MatchParen', { fg = colors.bg1, bg = colors.str })
vim.api.nvim_set_hl(0, 'ErrorMsg', { fg = colors.warning, bg = colors.bg2 })
vim.api.nvim_set_hl(0, 'WarningMsg', { fg = colors.warning2 })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = colors.bg2, fg = colors.fg2 })
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = colors.bg3, fg = colors.fg3 })
vim.api.nvim_set_hl(0, 'WildMenu', { bg = colors.bg3, fg = colors.fg3 })
vim.api.nvim_set_hl(0, 'Folded', { bg = colors.bg2, fg = colors.fg4 })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = colors.bg1 })
vim.api.nvim_set_hl(0, 'NonText', { fg = colors.fg4 })
vim.api.nvim_set_hl(0, 'SpecialKey', { fg = colors.fg4 })
vim.api.nvim_set_hl(0, 'Directory', { fg = colors.type })
vim.api.nvim_set_hl(0, 'Title', { fg = colors.fg1, bold = true })
vim.api.nvim_set_hl(0, 'DiffAdd', { bg = '#004d00' })
vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#4d0000' })
vim.api.nvim_set_hl(0, 'DiffChange', { bg = '#4d4d00' })
vim.api.nvim_set_hl(0, 'DiffText', { bg = '#666600' })
vim.api.nvim_set_hl(0, 'SpellBad', { undercurl = true, sp = colors.warning })
vim.api.nvim_set_hl(0, 'SpellCap', { undercurl = true, sp = colors.warning2 })
vim.api.nvim_set_hl(0, 'SpellRare', { undercurl = true, sp = colors.fg3 })
vim.api.nvim_set_hl(0, 'SpellLocal', { undercurl = true, sp = colors.fg4 })

-- For indent line plugin
vim.api.nvim_set_hl(0, 'IblIndent', { fg = "#241717" })
vim.api.nvim_set_hl(0, 'IblWhitespace', { fg = colors.grey })
vim.api.nvim_set_hl(0, 'IblScope', { fg = colors.grey })
