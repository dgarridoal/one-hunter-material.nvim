local M = {}

-- Color Palette (One Hunter Material)
local colors = {
	bg = "#1D2126",
	fg = "#E3E1E1",
	bg_highlight = "#2B2E31",
	bg_selection = "#E3E1E133",
	hover_bg = "#3D4043",
	find_bg = "#bc5412",
	find_bg_dim = "#bc5412cc",
	range_highlight = "#46494D",

	line_numbers = "#46494D",
	comment = "#7F8286",
	cursor_line = "#2B2E31",
	border = "#3D4043",

	red = "#f06292",
	green = "#66dfc4",
	yellow = "#f7bc62",
	blue = "#64b5f6",
	cyan = "#4fc3f7",
	magenta = "#d88ee4",
	orange = "#f4a343",

	red_dim = "#bb1b3f99",
	green_dim = "#176e6199",
	blue_dim = "#05699f",
	orange_dim = "#bc5412",

	error = "#f06292",
	warning = "#f4a343",
	info = "#64b5f6",
	hint = "#66dfc4",
	none = "NONE",
}

-- Define default options for plugin
local default_opts = {
	transparent_background = false,
}

-- Generate highlights
local function setup_highlights()
	local hl = {
		Normal = { fg = colors.fg, bg = colors.bg },
		NormalNC = { fg = colors.fg, bg = colors.bg },
		NormalFloat = { fg = colors.fg, bg = colors.cursor_line },
		Cursor = { fg = colors.bg, bg = colors.fg },
		CursorLine = { bg = colors.cursor_line },
		CursorLineNr = { fg = colors.fg, bold = true },
		LineNr = { fg = colors.line_numbers },
		SignColumn = { bg = colors.bg },
		ColorColumn = { bg = colors.bg_highlight },
		Conceal = { fg = colors.comment },
		CursorColumn = { bg = colors.cursor_line },

		Search = { fg = colors.bg, bg = colors.yellow },
		IncSearch = { fg = colors.bg, bg = colors.yellow },

		Pmenu = { fg = colors.fg, bg = colors.bg_highlight },
		PmenuSel = { fg = colors.fg, bg = colors.hover_bg },
		PmenuSbar = { bg = colors.bg_highlight },
		PmenuThumb = { bg = colors.border },

		Visual = { bg = colors.hover_bg },
		VisualNOS = { bg = colors.hover_bg },
		WildMenu = { fg = colors.fg, bg = colors.hover_bg },

		TabLine = { fg = colors.comment, bg = colors.bg_highlight },
		TabLineFill = { bg = colors.bg },
		TabLineSel = { fg = colors.fg, bg = colors.bg },

		StatusLine = { fg = colors.fg, bg = colors.bg },
		StatusLineNC = { fg = colors.comment, bg = colors.bg_highlight },

		VertSplit = { fg = colors.border },
		Folded = { fg = colors.comment, bg = colors.bg_highlight },
		FoldColumn = { fg = colors.comment },
		FloatBorder = { fg = colors.border, bg = colors.bg_highlight },

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

		DiffAdd = { bg = colors.green_dim },
		DiffChange = { bg = colors.blue_dim },
		DiffDelete = { bg = colors.red_dim },
		DiffText = { bg = colors.blue },

		SpellBad = { sp = colors.error, undercurl = true },
		SpellCap = { sp = colors.warning, undercurl = true },
		SpellRare = { sp = colors.info, undercurl = true },
		SpellLocal = { sp = colors.info, undercurl = true },

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
	}

	for group, style in pairs(hl) do
		if type(vim.api.nvim_set_hl) == "function" then
			-- Neovim >= 0.7
			local ok, err = pcall(vim.api.nvim_set_hl, 0, group, style)
			if not ok then
				vim.notify(
					string.format("one-hunter-material error setting hl %s: %s", group, err),
					vim.log.levels.ERROR
				)
			end
		else
			-- Fallback for older Neovim versions
			local cmd = { "highlight", group }
			if style.fg then
				table.insert(cmd, "guifg=" .. style.fg)
			end
			if style.bg then
				table.insert(cmd, "guibg=" .. style.bg)
			end
			if style.sp then
				table.insert(cmd, "guisp=" .. style.sp)
			end
			if style.bold then
				table.insert(cmd, "gui=bold")
			end
			if style.italic then
				table.insert(cmd, "gui=italic")
			end
			if style.undercurl then
				table.insert(cmd, "guisp=" .. style.sp, "gui=undercurl")
			end
			vim.cmd(table.concat(cmd, " "))
		end
	end
end

-- Setup function called by LazyVim
function M.setup(opts)
	opts = vim.tbl_deep_extend("force", default_opts, opts or {})
	-- Activate true color support
	vim.o.termguicolors = true
	-- Clear existing highlights
	vim.cmd("hi clear")

	-- Apply transparent background if requested
	if opts.transparent_background then
		colors.bg = colors.none
		colors.cursor_line = colors.none
		colors.bg_highlight = colors.none
	end

	-- Generate and apply highlights
	setup_highlights()
	-- Set colorscheme name for LazyVim
	vim.g.colors_name = "one-hunter-material"
end

return M
