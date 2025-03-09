-- one-hunter-material.lua
-- A dark theme with a material-inspired color palette

local M = {}

-- Color Palette
local colors = {
  bg = "#1D2126",
  fg = "#E3E1E1",
  bg_highlight = "#2B2E31",
  bg_selection = "#3D4043",
  line_numbers = "#46494D",
  comment = "#7F8286",
  cursor_line = "#2B2E31",
  border = "#3D4043",
  
  -- Main colors
  red = "#f06292",
  green = "#66dfc4",
  yellow = "#f7bc62",
  blue = "#64b5f6",
  cyan = "#4fc3f7",
  magenta = "#d88ee4",
  orange = "#f4a343",
  
  -- Dimmed variations
  red_dim = "#bb1b3f",
  green_dim = "#176e61",
  blue_dim = "#05699f",
  orange_dim = "#bc5412",
  
  -- UI elements
  error = "#f06292",
  warning = "#f4a343",
  info = "#64b5f6",
  hint = "#66dfc4",
  
  -- Special colors
  none = "NONE",
}

function M.setup()
  -- Reset highlighting
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  
  -- Set colorscheme name
  vim.g.colors_name = "one-hunter-material"
  
  -- Set terminal colors
  vim.g.terminal_color_0 = colors.bg
  vim.g.terminal_color_1 = colors.red
  vim.g.terminal_color_2 = colors.green
  vim.g.terminal_color_3 = colors.yellow
  vim.g.terminal_color_4 = colors.blue
  vim.g.terminal_color_5 = colors.magenta
  vim.g.terminal_color_6 = colors.cyan
  vim.g.terminal_color_7 = colors.fg
  vim.g.terminal_color_8 = colors.comment
  vim.g.terminal_color_9 = colors.red
  vim.g.terminal_color_10 = colors.green
  vim.g.terminal_color_11 = colors.yellow
  vim.g.terminal_color_12 = colors.blue
  vim.g.terminal_color_13 = colors.magenta
  vim.g.terminal_color_14 = colors.cyan
  vim.g.terminal_color_15 = colors.fg
  
  -- Define highlight groups
  local highlights = {
    -- Neovim standard groups
    Normal = { fg = colors.fg, bg = colors.bg },
    NormalFloat = { fg = colors.fg, bg = colors.bg_highlight },
    NormalNC = { fg = colors.fg, bg = colors.bg },
    Cursor = { fg = colors.bg, bg = colors.fg },
    CursorLine = { bg = colors.cursor_line },
    CursorLineNr = { fg = colors.fg, bold = true },
    LineNr = { fg = colors.line_numbers },
    SignColumn = { bg = colors.bg },
    ColorColumn = { bg = colors.bg_highlight },
    Conceal = { fg = colors.comment },
    CursorColumn = { bg = colors.cursor_line },
    
    -- Search
    IncSearch = { fg = colors.bg, bg = colors.yellow },
    Search = { fg = colors.bg, bg = colors.yellow },
    
    -- Borders and splits
    VertSplit = { fg = colors.border },
    FloatBorder = { fg = colors.border, bg = colors.bg_highlight },
    TabLine = { fg = colors.comment, bg = colors.bg_highlight },
    TabLineFill = { bg = colors.bg },
    TabLineSel = { fg = colors.fg, bg = colors.bg },
    Title = { fg = colors.cyan, bold = true },
    
    -- Statusline
    StatusLine = { fg = colors.fg, bg = colors.bg },
    StatusLineNC = { fg = colors.comment, bg = colors.bg_highlight },
    
    -- Folds
    Folded = { fg = colors.comment, bg = colors.bg_highlight },
    FoldColumn = { fg = colors.comment },
    
    -- Menus
    Pmenu = { fg = colors.fg, bg = colors.bg_highlight },
    PmenuSel = { fg = colors.fg, bg = colors.bg_selection },
    PmenuSbar = { bg = colors.bg_highlight },
    PmenuThumb = { bg = colors.border },
    WildMenu = { fg = colors.fg, bg = colors.bg_selection },
    
    -- Visual
    Visual = { bg = colors.bg_selection },
    VisualNOS = { bg = colors.bg_selection },
    
    -- Messages
    ErrorMsg = { fg = colors.error },
    WarningMsg = { fg = colors.warning },
    MoreMsg = { fg = colors.green },
    Question = { fg = colors.green },
    
    -- Diagnostics
    DiagnosticError = { fg = colors.error },
    DiagnosticWarn = { fg = colors.warning },
    DiagnosticInfo = { fg = colors.info },
    DiagnosticHint = { fg = colors.hint },
    DiagnosticUnderlineError = { sp = colors.error, undercurl = true },
    DiagnosticUnderlineWarn = { sp = colors.warning, undercurl = true },
    DiagnosticUnderlineInfo = { sp = colors.info, undercurl = true },
    DiagnosticUnderlineHint = { sp = colors.hint, undercurl = true },
    
    -- Diff
    DiffAdd = { bg = colors.green_dim },
    DiffChange = { bg = colors.blue_dim },
    DiffDelete = { bg = colors.red_dim },
    DiffText = { bg = colors.blue },
    
    -- Spelling
    SpellBad = { sp = colors.error, undercurl = true },
    SpellCap = { sp = colors.warning, undercurl = true },
    SpellRare = { sp = colors.info, undercurl = true },
    SpellLocal = { sp = colors.info, undercurl = true },
    
    -- Syntax highlighting
    Comment = { fg = colors.comment, italic = true },
    Constant = { fg = colors.fg },
    String = { fg = colors.green },
    Character = { fg = colors.green },
    Number = { fg = colors.yellow },
    Boolean = { fg = colors.cyan },
    Float = { fg = colors.yellow },
    
    Identifier = { fg = colors.fg },
    Function = { fg = colors.cyan, bold = true },
    
    Statement = { fg = colors.red },
    Conditional = { fg = colors.red },
    Repeat = { fg = colors.red },
    Label = { fg = colors.cyan },
    Operator = { fg = colors.blue },
    Keyword = { fg = colors.red },
    Exception = { fg = colors.cyan },
    
    PreProc = { fg = colors.cyan },
    Include = { fg = colors.red },
    Define = { fg = colors.red },
    Macro = { fg = colors.blue },
    PreCondit = { fg = colors.cyan },
    
    Type = { fg = colors.blue },
    StorageClass = { fg = colors.red },
    Structure = { fg = colors.yellow },
    Typedef = { fg = colors.yellow },
    
    Special = { fg = colors.fg },
    SpecialChar = { fg = colors.fg },
    Tag = { fg = colors.red },
    Delimiter = { fg = colors.fg },
    SpecialComment = { fg = colors.comment, italic = true },
    Debug = { fg = colors.red },
    
    Underlined = { underline = true },
    Ignore = { fg = colors.comment },
    Error = { fg = colors.error },
    Todo = { fg = colors.yellow, bold = true },
    
    -- TreeSitter (for newer versions)
    ["@comment"] = { link = "Comment" },
    ["@error"] = { link = "Error" },
    ["@none"] = { bg = colors.none, fg = colors.none },
    ["@preproc"] = { link = "PreProc" },
    ["@define"] = { link = "Define" },
    ["@operator"] = { link = "Operator" },
    
    ["@punctuation.delimiter"] = { fg = colors.fg },
    ["@punctuation.bracket"] = { fg = colors.fg },
    ["@punctuation.special"] = { fg = colors.fg },
    
    ["@string"] = { link = "String" },
    ["@string.regex"] = { fg = colors.orange },
    ["@string.escape"] = { fg = colors.fg },
    ["@string.special"] = { fg = colors.fg },
    
    ["@character"] = { link = "Character" },
    ["@character.special"] = { fg = colors.fg },
    ["@boolean"] = { link = "Boolean" },
    ["@number"] = { link = "Number" },
    ["@float"] = { link = "Float" },
    
    ["@function"] = { link = "Function" },
    ["@function.builtin"] = { fg = colors.cyan },
    ["@function.call"] = { fg = colors.cyan },
    ["@function.macro"] = { fg = colors.blue },
    ["@method"] = { fg = colors.cyan },
    ["@method.call"] = { fg = colors.cyan },
    ["@constructor"] = { fg = colors.yellow },
    ["@parameter"] = { fg = colors.fg },
    
    ["@keyword"] = { link = "Keyword" },
    ["@keyword.function"] = { fg = colors.red },
    ["@keyword.operator"] = { fg = colors.blue },
    ["@keyword.return"] = { fg = colors.red },
    
    ["@conditional"] = { link = "Conditional" },
    ["@repeat"] = { link = "Repeat" },
    ["@label"] = { link = "Label" },
    ["@include"] = { link = "Include" },
    ["@exception"] = { link = "Exception" },
    
    ["@type"] = { link = "Type" },
    ["@type.builtin"] = { fg = colors.blue },
    ["@type.definition"] = { fg = colors.blue },
    ["@type.qualifier"] = { fg = colors.red },
    
    ["@storageclass"] = { link = "StorageClass" },
    ["@attribute"] = { fg = colors.yellow },
    ["@field"] = { fg = colors.fg },
    ["@property"] = { fg = colors.fg },
    
    ["@variable"] = { fg = colors.fg },
    ["@variable.builtin"] = { fg = colors.cyan },
    
    ["@constant"] = { link = "Constant" },
    ["@constant.builtin"] = { fg = colors.cyan },
    ["@constant.macro"] = { fg = colors.blue },
    
    ["@namespace"] = { fg = colors.yellow },
    ["@symbol"] = { fg = colors.fg },
    
    ["@text"] = { fg = colors.fg },
    ["@text.title"] = { fg = colors.cyan, bold = true },
    ["@text.literal"] = { fg = colors.green },
    ["@text.uri"] = { fg = colors.blue, underline = true },
    ["@text.emphasis"] = { italic = true },
    ["@text.strong"] = { bold = true },
    ["@text.reference"] = { fg = colors.blue },
    
    ["@tag"] = { link = "Tag" },
    ["@tag.attribute"] = { fg = colors.yellow },
    ["@tag.delimiter"] = { fg = colors.fg },
    
    -- LSP semantic tokens
    ["@lsp.type.class"] = { link = "@type" },
    ["@lsp.type.comment"] = { link = "@comment" },
    ["@lsp.type.decorator"] = { link = "@attribute" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.function"] = { link = "@function" },
    ["@lsp.type.interface"] = { link = "@type" },
    ["@lsp.type.macro"] = { link = "@constant.macro" },
    ["@lsp.type.method"] = { link = "@method" },
    ["@lsp.type.namespace"] = { link = "@namespace" },
    ["@lsp.type.parameter"] = { link = "@parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.struct"] = { link = "@type" },
    ["@lsp.type.type"] = { link = "@type" },
    ["@lsp.type.typeParameter"] = { link = "@type.definition" },
    ["@lsp.type.variable"] = { link = "@variable" },
    
    -- Git
    GitSignsAdd = { fg = colors.green },
    GitSignsChange = { fg = colors.blue },
    GitSignsDelete = { fg = colors.red },
    
    -- Telescope
    TelescopeNormal = { fg = colors.fg, bg = colors.bg },
    TelescopeBorder = { fg = colors.border, bg = colors.bg },
    TelescopePromptBorder = { fg = colors.border, bg = colors.bg_highlight },
    TelescopeResultsBorder = { fg = colors.border, bg = colors.bg },
    TelescopePreviewBorder = { fg = colors.border, bg = colors.bg },
    TelescopeSelectionCaret = { fg = colors.cyan },
    TelescopeSelection = { fg = colors.fg, bg = colors.bg_selection },
    TelescopeMatching = { fg = colors.yellow, bold = true },
    
    -- NvimTree
    NvimTreeNormal = { fg = colors.fg, bg = colors.bg },
    NvimTreeRootFolder = { fg = colors.blue, bold = true },
    NvimTreeFolderIcon = { fg = colors.green },
    NvimTreeFileIcon = { fg = colors.blue },
    NvimTreeSpecialFile = { fg = colors.cyan, underline = true },
    NvimTreeIndentMarker = { fg = colors.border },
    NvimTreeGitDirty = { fg = colors.orange },
    NvimTreeGitStaged = { fg = colors.green },
    NvimTreeGitNew = { fg = colors.green },
    NvimTreeGitDeleted = { fg = colors.red },
    
    -- Neogit
    NeogitBranch = { fg = colors.yellow },
    NeogitRemote = { fg = colors.cyan },
    NeogitHunkHeader = { fg = colors.fg, bg = colors.bg_highlight },
    NeogitDiffAdd = { fg = colors.green },
    NeogitDiffDelete = { fg = colors.red },
    
    -- Dashboard
    DashboardHeader = { fg = colors.cyan },
    DashboardCenter = { fg = colors.yellow },
    DashboardFooter = { fg = colors.comment, italic = true },
    
    -- WhichKey
    WhichKey = { fg = colors.cyan },
    WhichKeyGroup = { fg = colors.blue },
    WhichKeyDesc = { fg = colors.fg },
    WhichKeySeparator = { fg = colors.comment },
    
    -- BufferLine
    BufferLineFill = { bg = colors.bg },
    BufferLineBackground = { fg = colors.comment, bg = colors.bg_highlight },
    BufferLineBufferSelected = { fg = colors.fg, bg = colors.bg },
    BufferLineModified = { fg = colors.yellow, bg = colors.bg_highlight },
    BufferLineModifiedSelected = { fg = colors.yellow, bg = colors.bg },
    
    -- Indent Blankline
    IndentBlanklineChar = { fg = colors.border },
    IndentBlanklineContextChar = { fg = colors.comment },
  }
  
  -- Apply highlight groups
  for group, styles in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, styles)
  end
end

return M
