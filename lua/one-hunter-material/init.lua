local M = {}

-- Color Palette (One Hunter Material)
local colors = {
	bg = "#1D2126", -- editor.background
	fg = "#E3E1E1", -- editor.foreground
	bg_highlight = "#2B2E31", -- line highlight, inactive selection background
	bg_selection = "#E3E1E1" .. "33", -- selection background (alpha 20%)
	hover_bg = "#3D4043", -- hover highlight background
	find_bg = "#bc5412", -- find match background
	find_bg_dim = "#bc5412cc", -- find match highlight background
	range_highlight = "#46494D", -- range highlight background

	line_numbers = "#46494D", -- editorLineNumber.foreground
	comment = "#7F8286", -- comments, inactive foreground
	cursor_line = "#2B2E31", -- editor.lineHighlightBackground
	border = "#3D4043", -- borders (FloatBorder, peekView border, etc.)

	red = "#f06292", -- errors, keywords
	green = "#66dfc4", -- strings, diff adds
	yellow = "#f7bc62", -- numbers, warnings
	blue = "#64b5f6", -- operators, types
	cyan = "#4fc3f7", -- functions, hints
	magenta = "#d88ee4", -- decorators
	orange = "#f4a343", -- warnings, accents

	red_dim = "#bb1b3f99", -- removed text background dim
	green_dim = "#176e6199", -- inserted text background dim
	blue_dim = "#05699f", -- incoming merge content background
	orange_dim = "#bc5412", -- diff change header

	error = "#f06292", -- DiagnosticError
	warning = "#f4a343", -- DiagnosticWarn
	info = "#64b5f6", -- DiagnosticInfo
	hint = "#66dfc4", -- DiagnosticHint
	none = "NONE",
}

local function setup_highlights()
	local hl = {
		-- UI Basics
		Normal = { fg = colors.fg, bg = colors.bg },
		NormalFloat = { fg = colors.fg, bg = colors.cursor_line },
		NormalNC = { fg = colors.fg, bg = colors.bg },
		Cursor = { fg = colors.bg, bg = colors.fg },
		CursorLine = { bg = colors.cursor_line },
		CursorLineNr = { fg = colors.fg, bold = true },
		LineNr = { fg = colors.line_numbers },
		SignColumn = { bg = colors.bg },
		ColorColumn = { bg = colors.bg_highlight },
		Conceal = { fg = colors.comment },
		CursorColumn = { bg = colors.cursor_line },

		-- Search & Find
		IncSearch = { fg = colors.bg, bg = colors.yellow },
		Search = { fg = colors.bg, bg = colors.yellow },

		-- UI elements
		VertSplit = { fg = colors.border },
		FloatBorder = { fg = colors.border, bg = colors.bg_highlight },
		TabLine = { fg = colors.comment, bg = colors.bg_highlight },
		TabLineFill = { bg = colors.bg },
		TabLineSel = { fg = colors.fg, bg = colors.bg },
		Title = { fg = colors.cyan, bold = true },
		StatusLine = { fg = colors.fg, bg = colors.bg },
		StatusLineNC = { fg = colors.comment, bg = colors.bg_highlight },
		Folded = { fg = colors.comment, bg = colors.bg_highlight },
		FoldColumn = { fg = colors.comment },
		Pmenu = { fg = colors.fg, bg = colors.bg_highlight },
		PmenuSel = { fg = colors.fg, bg = colors.hover_bg },
		PmenuSbar = { bg = colors.bg_highlight },
		PmenuThumb = { bg = colors.border },
		WildMenu = { fg = colors.fg, bg = colors.hover_bg },
		Visual = { bg = colors.hover_bg },
		VisualNOS = { bg = colors.hover_bg },

		-- Diagnostics
		ErrorMsg = { fg = colors.error },
		WarningMsg = { fg = colors.warning },
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

		-- Spell
		SpellBad = { sp = colors.error, undercurl = true },
		SpellCap = { sp = colors.warning, undercurl = true },
		SpellRare = { sp = colors.info, undercurl = true },
		SpellLocal = { sp = colors.info, undercurl = true },

		-- Syntax
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
		Macro = { fg = colors.blue },
		Type = { fg = colors.blue },
		StorageClass = { fg = colors.red },
		Structure = { fg = colors.yellow },
		Typedef = { fg = colors.yellow },
		Special = { fg = colors.fg },
		SpecialChar = { fg = colors.fg },
		Tag = { fg = colors.red },
		Delimiter = { fg = colors.fg },
		SpecialComment = { fg = colors.comment, italic = true },
		Underlined = { underline = true },
		Ignore = { fg = colors.comment },
		Error = { fg = colors.error },
		Todo = { fg = colors.yellow, bold = true },

		-- Treesitter
		["@comment"] = { link = "Comment" },
		["@error"] = { link = "Error" },
		["@none"] = { bg = colors.none, fg = colors.none },
		["@preproc"] = { link = "PreProc" },
		["@define"] = { link = "Macro" },
		["@operator"] = { link = "Operator" },
		["@punctuation.delimiter"] = { fg = colors.fg },
		["@punctuation.bracket"] = { fg = colors.fg },
		["@punctuation.special"] = { fg = colors.fg },
		["@string"] = { link = "String" },
		["@string.regex"] = { fg = colors.orange },
		["@character"] = { link = "Character" },
		["@boolean"] = { link = "Boolean" },
		["@number"] = { link = "Number" },
		["@float"] = { link = "Float" },
		["@function"] = { link = "Function" },
		["@function.builtin"] = { fg = colors.cyan },
		["@function.call"] = { fg = colors.cyan },
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
		["@text.todo"] = { fg = colors.yellow, bold = true },
		["@text.todo.checked"] = { fg = colors.green },
		["@text.todo.unchecked"] = { fg = colors.red },
		["@text.diff.add"] = { fg = colors.green },
		["@text.diff.remove"] = { fg = colors.red },
	}

	for group, style in pairs(hl) do
		vim.api.nvim_set_hl(0, group, style)
	end
end

function M.setup()
	vim.o.termguicolors = true
	vim.cmd("hi clear")
	setup_highlights()
end

return M
