local colors = require("one_hunter_material.colors")

local M = {}

function M.setup()
	vim.o.termguicolors = true
	vim.cmd("hi clear")
	vim.cmd("syntax reset")

	-- Setup highlights
	local function setup_highlights()
		local hl = {
			-- Basic highlights
			Normal = { fg = colors.fg, bg = colors.bg },
			NormalNC = { fg = colors.fg, bg = colors.bg },
			NormalFloat = { fg = colors.fg, bg = colors.widget_bg },
			FloatBorder = { fg = colors.border, bg = colors.widget_bg },
			FloatTitle = { fg = colors.fg, bg = colors.widget_bg, bold = true },

			-- Cursor
			Cursor = { fg = colors.bg, bg = colors.fg },
			CursorLine = { bg = colors.cursor_line },
			CursorLineNr = { fg = colors.line_numbers_active, bold = true },
			CursorColumn = { bg = colors.cursor_line },

			-- Line numbers
			LineNr = { fg = colors.line_numbers },
			SignColumn = { bg = colors.bg },
			ColorColumn = { bg = colors.bg_highlight },

			-- Concealed text
			Conceal = { fg = colors.comment },

			-- Search
			Search = { fg = colors.bg, bg = colors.yellow },
			IncSearch = { fg = colors.bg, bg = colors.yellow },
			CurSearch = { fg = colors.bg, bg = colors.orange },

			-- Visual selection
			Visual = { bg = colors.hover_bg },
			VisualNOS = { bg = colors.hover_bg },

			-- Popups
			Pmenu = { fg = colors.fg, bg = colors.bg_highlight },
			PmenuSel = { fg = colors.fg, bg = colors.hover_bg },
			PmenuSbar = { bg = colors.bg_highlight },
			PmenuThumb = { bg = colors.border },
			PmenuKind = { fg = colors.cyan },
			PmenuKindSel = { fg = colors.cyan, bg = colors.hover_bg },
			PmenuExtra = { fg = colors.comment },
			PmenuExtraSel = { fg = colors.comment, bg = colors.hover_bg },

			-- Wildmenu
			WildMenu = { fg = colors.fg, bg = colors.hover_bg },

			-- Tabs
			TabLine = { fg = colors.tab_inactive_fg, bg = colors.tab_inactive_bg },
			TabLineFill = { bg = colors.bg },
			TabLineSel = { fg = colors.tab_active_fg, bg = colors.tab_active_bg },

			-- Status line
			StatusLine = { fg = colors.fg, bg = colors.bg },
			StatusLineNC = { fg = colors.comment, bg = colors.bg_highlight },

			-- Window separators
			WinSeparator = { fg = colors.border },
			VertSplit = { fg = colors.border },

			-- Folding
			Folded = { fg = colors.comment, bg = colors.bg_highlight },
			FoldColumn = { fg = colors.comment },

			-- Messages
			ErrorMsg = { fg = colors.error },
			WarningMsg = { fg = colors.warning },
			ModeMsg = { fg = colors.fg },
			MoreMsg = { fg = colors.green },
			Question = { fg = colors.blue },

			-- Diagnostics
			DiagnosticError = { fg = colors.error },
			DiagnosticWarn = { fg = colors.warning },
			DiagnosticInfo = { fg = colors.info },
			DiagnosticHint = { fg = colors.hint },
			DiagnosticOk = { fg = colors.green },

			DiagnosticUnderlineError = { sp = colors.error, undercurl = true },
			DiagnosticUnderlineWarn = { sp = colors.warning, undercurl = true },
			DiagnosticUnderlineInfo = { sp = colors.info, undercurl = true },
			DiagnosticUnderlineHint = { sp = colors.hint, undercurl = true },
			DiagnosticUnderlineOk = { sp = colors.green, undercurl = true },

			DiagnosticVirtualTextError = { fg = colors.error, bg = colors.red_dim },
			DiagnosticVirtualTextWarn = { fg = colors.warning, bg = colors.orange_dim },
			DiagnosticVirtualTextInfo = { fg = colors.info, bg = colors.blue_dim },
			DiagnosticVirtualTextHint = { fg = colors.hint, bg = colors.green_dim },

			-- Diff
			DiffAdd = { bg = colors.diff_add },
			DiffChange = { bg = colors.diff_change },
			DiffDelete = { bg = colors.diff_delete },
			DiffText = { bg = colors.diff_text },

			-- Git gutter
			GitGutterAdd = { fg = colors.gutter_added },
			GitGutterChange = { fg = colors.gutter_modified },
			GitGutterDelete = { fg = colors.gutter_deleted },
			GitGutterChangeDelete = { fg = colors.gutter_modified },

			-- GitSigns
			GitSignsAdd = { fg = colors.gutter_added },
			GitSignsChange = { fg = colors.gutter_modified },
			GitSignsDelete = { fg = colors.gutter_deleted },

			-- Spell checking
			SpellBad = { sp = colors.error, undercurl = true },
			SpellCap = { sp = colors.warning, undercurl = true },
			SpellRare = { sp = colors.info, undercurl = true },
			SpellLocal = { sp = colors.info, undercurl = true },

			-- Whitespace
			Whitespace = { fg = colors.whitespace },
			NonText = { fg = colors.whitespace },
			SpecialKey = { fg = colors.whitespace },

			-- Bracket matching
			MatchParen = { bg = colors.bracket_match_bg, fg = colors.fg, bold = true },

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
			Define = { fg = colors.blue },
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
			Debug = { fg = colors.orange },

			Underlined = { underline = true },
			Ignore = { fg = colors.comment },
			Error = { fg = colors.error },
			Todo = { fg = colors.yellow, bold = true },

			-- Treesitter highlights
			["@comment"] = { link = "Comment" },
			["@comment.documentation"] = { fg = colors.comment, italic = true },

			["@error"] = { link = "Error" },
			["@none"] = { bg = colors.none, fg = colors.none },
			["@preproc"] = { link = "PreProc" },
			["@define"] = { link = "Define" },
			["@operator"] = { link = "Operator" },

			["@punctuation.delimiter"] = { fg = colors.fg },
			["@punctuation.bracket"] = { fg = colors.fg },
			["@punctuation.special"] = { fg = colors.fg },

			["@string"] = { link = "String" },
			["@string.documentation"] = { fg = colors.green, italic = true },
			["@string.regex"] = { fg = colors.orange },
			["@string.escape"] = { fg = colors.orange },
			["@string.special"] = { fg = colors.orange },

			["@character"] = { link = "Character" },
			["@character.special"] = { fg = colors.orange },

			["@boolean"] = { link = "Boolean" },
			["@number"] = { link = "Number" },
			["@number.float"] = { link = "Float" },

			["@function"] = { link = "Function" },
			["@function.builtin"] = { fg = colors.cyan },
			["@function.call"] = { fg = colors.cyan },
			["@function.macro"] = { fg = colors.blue },

			["@method"] = { fg = colors.cyan },
			["@method.call"] = { fg = colors.cyan },
			["@constructor"] = { fg = colors.yellow },

			["@parameter"] = { fg = colors.fg },
			["@parameter.builtin"] = { fg = colors.orange },
			["@parameter.reference"] = { fg = colors.fg },

			["@field"] = { fg = colors.fg },
			["@property"] = { fg = colors.fg },

			["@variable"] = { fg = colors.fg },
			["@variable.builtin"] = { fg = colors.orange },
			["@variable.parameter"] = { fg = colors.fg },
			["@variable.member"] = { fg = colors.fg },

			["@constant"] = { fg = colors.fg },
			["@constant.builtin"] = { fg = colors.cyan },
			["@constant.macro"] = { fg = colors.blue },

			["@namespace"] = { fg = colors.yellow },
			["@module"] = { fg = colors.yellow },

			["@symbol"] = { fg = colors.fg },

			["@text"] = { fg = colors.fg },
			["@text.literal"] = { fg = colors.green },
			["@text.reference"] = { fg = colors.blue },
			["@text.title"] = { fg = colors.yellow, bold = true },
			["@text.uri"] = { fg = colors.blue, underline = true },
			["@text.underline"] = { underline = true },
			["@text.todo"] = { fg = colors.yellow, bold = true },
			["@text.note"] = { fg = colors.info, bold = true },
			["@text.warning"] = { fg = colors.warning, bold = true },
			["@text.danger"] = { fg = colors.error, bold = true },

			["@markup.strong"] = { bold = true },
			["@markup.italic"] = { italic = true },
			["@markup.strikethrough"] = { strikethrough = true },
			["@markup.underline"] = { underline = true },
			["@markup.heading"] = { fg = colors.yellow, bold = true },
			["@markup.raw"] = { fg = colors.green },
			["@markup.link"] = { fg = colors.blue },
			["@markup.link.url"] = { fg = colors.blue, underline = true },
			["@markup.link.label"] = { fg = colors.cyan },
			["@markup.list"] = { fg = colors.red },
			["@markup.list.checked"] = { fg = colors.green },
			["@markup.list.unchecked"] = { fg = colors.comment },

			["@tag"] = { fg = colors.red },
			["@tag.attribute"] = { fg = colors.yellow },
			["@tag.delimiter"] = { fg = colors.fg },

			["@keyword"] = { link = "Keyword" },
			["@keyword.coroutine"] = { fg = colors.red },
			["@keyword.function"] = { fg = colors.red },
			["@keyword.operator"] = { fg = colors.blue },
			["@keyword.import"] = { fg = colors.red },
			["@keyword.type"] = { fg = colors.red },
			["@keyword.modifier"] = { fg = colors.red },
			["@keyword.repeat"] = { fg = colors.red },
			["@keyword.return"] = { fg = colors.red },
			["@keyword.debug"] = { fg = colors.orange },
			["@keyword.exception"] = { fg = colors.cyan },
			["@keyword.conditional"] = { fg = colors.red },
			["@keyword.conditional.ternary"] = { fg = colors.blue },
			["@keyword.directive"] = { fg = colors.cyan },
			["@keyword.directive.define"] = { fg = colors.blue },

			["@conditional"] = { link = "Conditional" },
			["@conditional.ternary"] = { fg = colors.blue },
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
			["@annotation"] = { fg = colors.yellow },

			-- LSP semantic tokens
			["@lsp.type.class"] = { fg = colors.yellow },
			["@lsp.type.decorator"] = { fg = colors.yellow },
			["@lsp.type.enum"] = { fg = colors.yellow },
			["@lsp.type.enumMember"] = { fg = colors.cyan },
			["@lsp.type.function"] = { fg = colors.cyan },
			["@lsp.type.interface"] = { fg = colors.yellow },
			["@lsp.type.macro"] = { fg = colors.blue },
			["@lsp.type.method"] = { fg = colors.cyan },
			["@lsp.type.namespace"] = { fg = colors.yellow },
			["@lsp.type.parameter"] = { fg = colors.fg },
			["@lsp.type.property"] = { fg = colors.fg },
			["@lsp.type.struct"] = { fg = colors.yellow },
			["@lsp.type.type"] = { fg = colors.blue },
			["@lsp.type.typeParameter"] = { fg = colors.yellow },
			["@lsp.type.variable"] = { fg = colors.fg },

			-- Plugin specific highlights

			-- Telescope
			TelescopeNormal = { fg = colors.fg, bg = colors.bg },
			TelescopeBorder = { fg = colors.border, bg = colors.bg },
			TelescopePromptNormal = { fg = colors.fg, bg = colors.bg_highlight },
			TelescopePromptBorder = { fg = colors.border, bg = colors.bg_highlight },
			TelescopePromptTitle = { fg = colors.fg, bg = colors.bg_highlight },
			TelescopePreviewTitle = { fg = colors.fg, bg = colors.bg },
			TelescopeResultsTitle = { fg = colors.fg, bg = colors.bg },
			TelescopeSelection = { fg = colors.fg, bg = colors.hover_bg },
			TelescopeSelectionCaret = { fg = colors.red, bg = colors.hover_bg },
			TelescopeMultiSelection = { fg = colors.fg, bg = colors.hover_bg },
			TelescopeMatching = { fg = colors.yellow, bold = true },

			-- Neo-tree
			NeoTreeNormal = { fg = colors.fg, bg = colors.sidebar_bg },
			NeoTreeNormalNC = { fg = colors.fg, bg = colors.sidebar_bg },
			NeoTreeDirectoryName = { fg = colors.fg },
			NeoTreeDirectoryIcon = { fg = colors.gutter_added },
			NeoTreeFileName = { fg = colors.fg },
			NeoTreeFileIcon = { fg = colors.blue },
			NeoTreeIndentMarker = { fg = colors.indent_guide },
			NeoTreeExpander = { fg = colors.comment },
			NeoTreeGitAdded = { fg = colors.gutter_added },
			NeoTreeGitDeleted = { fg = colors.gutter_deleted },
			NeoTreeGitModified = { fg = colors.gutter_modified },
			NeoTreeGitConflict = { fg = colors.warning },
			NeoTreeGitUntracked = { fg = colors.comment },
			NeoTreeGitIgnored = { fg = colors.comment },
			NeoTreeGitStaged = { fg = colors.green },
			NeoTreeGitUnstaged = { fg = colors.orange },

			-- Which-key
			WhichKey = { fg = colors.cyan },
			WhichKeyGroup = { fg = colors.blue },
			WhichKeyDesc = { fg = colors.fg },
			WhichKeySeperator = { fg = colors.comment },
			WhichKeyFloat = { bg = colors.bg_highlight },
			WhichKeyBorder = { fg = colors.border },

			-- Notify
			NotifyERRORBorder = { fg = colors.error },
			NotifyWARNBorder = { fg = colors.warning },
			NotifyINFOBorder = { fg = colors.info },
			NotifyDEBUGBorder = { fg = colors.comment },
			NotifyTRACEBorder = { fg = colors.hint },
			NotifyERRORIcon = { fg = colors.error },
			NotifyWARNIcon = { fg = colors.warning },
			NotifyINFOIcon = { fg = colors.info },
			NotifyDEBUGIcon = { fg = colors.comment },
			NotifyTRACEIcon = { fg = colors.hint },
			NotifyERRORTitle = { fg = colors.error },
			NotifyWARNTitle = { fg = colors.warning },
			NotifyINFOTitle = { fg = colors.info },
			NotifyDEBUGTitle = { fg = colors.comment },
			NotifyTRACETitle = { fg = colors.hint },
			NotifyERRORBody = { fg = colors.fg },
			NotifyWARNBody = { fg = colors.fg },
			NotifyINFOBody = { fg = colors.fg },
			NotifyDEBUGBody = { fg = colors.fg },
			NotifyTRACEBody = { fg = colors.fg },

			-- Indent Blankline
			IblIndent = { fg = colors.indent_guide },
			IblScope = { fg = colors.border },

			-- Noice
			NoicePopup = { bg = colors.bg_highlight },
			NoicePopupBorder = { fg = colors.border },
			NoiceCmdlinePopup = { bg = colors.bg_highlight },
			NoiceCmdlinePopupBorder = { fg = colors.border },
			NoiceCmdlineIcon = { fg = colors.cyan },
			NoiceConfirm = { bg = colors.bg_highlight },
			NoiceConfirmBorder = { fg = colors.border },

			-- Lazy
			LazyNormal = { bg = colors.bg },
			LazyButton = { bg = colors.bg_highlight },
			LazyButtonActive = { bg = colors.hover_bg },
			LazyComment = { fg = colors.comment },
			LazyCommit = { fg = colors.comment },
			LazyCommitIssue = { fg = colors.red },
			LazyCommitScope = { fg = colors.cyan },
			LazyCommitType = { fg = colors.blue },
			LazyDimmed = { fg = colors.comment },
			LazyDir = { fg = colors.blue },
			LazyH1 = { fg = colors.yellow, bold = true },
			LazyH2 = { fg = colors.cyan, bold = true },
			LazyLocal = { fg = colors.green },
			LazyProgressDone = { fg = colors.green },
			LazyProgressTodo = { fg = colors.comment },
			LazyProp = { fg = colors.orange },
			LazyReasonCmd = { fg = colors.yellow },
			LazyReasonEvent = { fg = colors.cyan },
			LazyReasonFt = { fg = colors.green },
			LazyReasonImport = { fg = colors.blue },
			LazyReasonKeys = { fg = colors.orange },
			LazyReasonPlugin = { fg = colors.red },
			LazyReasonRuntime = { fg = colors.magenta },
			LazyReasonSource = { fg = colors.cyan },
			LazyReasonStart = { fg = colors.green },
			LazySpecial = { fg = colors.orange },
			LazyTaskError = { fg = colors.error },
			LazyTaskOutput = { fg = colors.fg },
			LazyUrl = { fg = colors.blue, underline = true },
			LazyValue = { fg = colors.green },

			-- Mason
			MasonHeader = { fg = colors.bg, bg = colors.cyan, bold = true },
			MasonHeaderSecondary = { fg = colors.bg, bg = colors.blue, bold = true },
			MasonHighlight = { fg = colors.cyan },
			MasonHighlightBlock = { fg = colors.bg, bg = colors.cyan },
			MasonHighlightBlockBold = { fg = colors.bg, bg = colors.cyan, bold = true },
			MasonHighlightSecondary = { fg = colors.blue },
			MasonHighlightBlockSecondary = { fg = colors.bg, bg = colors.blue },
			MasonHighlightBlockBoldSecondary = { fg = colors.bg, bg = colors.blue, bold = true },
			MasonMuted = { fg = colors.comment },
			MasonMutedBlock = { fg = colors.comment, bg = colors.bg_highlight },
			MasonMutedBlockBold = { fg = colors.comment, bg = colors.bg_highlight, bold = true },

			-- Cmp
			CmpItemAbbrDeprecated = { fg = colors.comment, strikethrough = true },
			CmpItemAbbrMatch = { fg = colors.yellow, bold = true },
			CmpItemAbbrMatchFuzzy = { fg = colors.yellow, bold = true },
			CmpItemKind = { fg = colors.cyan },
			CmpItemKindVariable = { fg = colors.fg },
			CmpItemKindInterface = { fg = colors.yellow },
			CmpItemKindText = { fg = colors.fg },
			CmpItemKindFunction = { fg = colors.cyan },
			CmpItemKindMethod = { fg = colors.cyan },
			CmpItemKindKeyword = { fg = colors.red },
			CmpItemKindProperty = { fg = colors.fg },
			CmpItemKindUnit = { fg = colors.orange },
			CmpItemKindConstructor = { fg = colors.yellow },
			CmpItemKindClass = { fg = colors.yellow },
			CmpItemKindModule = { fg = colors.yellow },
			CmpItemKindOperator = { fg = colors.blue },
			CmpItemKindReference = { fg = colors.orange },
			CmpItemKindEnum = { fg = colors.yellow },
			CmpItemKindEnumMember = { fg = colors.cyan },
			CmpItemKindStruct = { fg = colors.yellow },
			CmpItemKindValue = { fg = colors.green },
			CmpItemKindEvent = { fg = colors.orange },
			CmpItemKindFile = { fg = colors.blue },
			CmpItemKindFolder = { fg = colors.blue },
			CmpItemKindColor = { fg = colors.green },
			CmpItemKindConstant = { fg = colors.cyan },
			CmpItemKindSnippet = { fg = colors.green },
			CmpItemKindTypeParameter = { fg = colors.yellow },

			-- Dashboard
			DashboardShortCut = { fg = colors.cyan },
			DashboardHeader = { fg = colors.blue },
			DashboardCenter = { fg = colors.green },
			DashboardFooter = { fg = colors.comment },

			-- Alpha
			AlphaShortcut = { fg = colors.cyan },
			AlphaHeader = { fg = colors.blue },
			AlphaHeaderLabel = { fg = colors.orange },
			AlphaFooter = { fg = colors.comment },
			AlphaButtons = { fg = colors.green },

			-- Trouble
			TroubleText = { fg = colors.fg },
			TroubleCount = { fg = colors.red, bg = colors.bg_highlight },
			TroubleNormal = { fg = colors.fg, bg = colors.bg },

			-- Lualine
			lualine_a_normal = { fg = colors.bg, bg = colors.blue, bold = true },
			lualine_a_insert = { fg = colors.bg, bg = colors.green, bold = true },
			lualine_a_visual = { fg = colors.bg, bg = colors.magenta, bold = true },
			lualine_a_replace = { fg = colors.bg, bg = colors.red, bold = true },
			lualine_a_command = { fg = colors.bg, bg = colors.yellow, bold = true },
			lualine_b_normal = { fg = colors.fg, bg = colors.bg_highlight },
			lualine_c_normal = { fg = colors.fg, bg = colors.bg },
		}

		-- Apply all highlights
		for group, target in pairs(hl) do
			vim.api.nvim_set_hl(0, group, { hl = target })
		end
	end

	setup_highlights()

	vim.g.colors_name = "one-hunter-material"
end

return M
