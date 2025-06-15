local M = {}

-- Carga tus colores desde el nuevo archivo colors.lua
local colors = require("one-hunter-material.colors")

-- Función auxiliar para establecer highlights (simplifica la llamada)
local function set_hl(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

-- Función auxiliar para enlazar highlights (más legible para links)
local function link_hl(source_group, target_group)
	vim.api.nvim_set_hl(0, source_group, { link = target_group })
end

-- Esta es la función principal que aplicará todos los highlights
function M.apply_highlights(opts)
	-- Resetear todos los highlights para empezar de cero
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	-- Configuración base de Neovim
	vim.o.background = "dark" -- Basado en tu color 'bg'
	vim.cmd("set t_Co=256") -- Asegura 256 colores

	-- Aplicar opción de fondo transparente si está activada
	local actual_bg = colors.bg
	local actual_cursor_line_bg = colors.cursor_line
	local actual_bg_highlight = colors.bg_highlight

	if opts.transparent_background then
		actual_bg = colors.none
		actual_cursor_line_bg = colors.none
		actual_bg_highlight = colors.none
	end

	-- Highlights Básicos
	set_hl("Normal", { fg = colors.fg, bg = actual_bg })
	set_hl("NormalNC", { fg = colors.fg, bg = actual_bg })
	set_hl("NormalFloat", { fg = colors.fg, bg = colors.widget_bg })
	set_hl("FloatBorder", { fg = colors.border, bg = colors.widget_bg })
	set_hl("FloatTitle", { fg = colors.fg, bg = colors.widget_bg, bold = true })

	-- Cursor
	set_hl("Cursor", { fg = colors.bg, bg = colors.fg })
	set_hl("CursorLine", { bg = actual_cursor_line_bg })
	set_hl("CursorLineNr", { fg = colors.line_numbers_active, bold = true })
	set_hl("CursorColumn", { bg = actual_cursor_line_bg })

	-- Números de línea
	set_hl("LineNr", { fg = colors.line_numbers })
	set_hl("SignColumn", { bg = actual_bg })
	set_hl("ColorColumn", { bg = actual_bg_highlight })

	-- Texto oculto
	set_hl("Conceal", { fg = colors.comment })

	-- Búsqueda
	set_hl("Search", { fg = colors.bg, bg = colors.yellow })
	set_hl("IncSearch", { fg = colors.bg, bg = colors.yellow })
	set_hl("CurSearch", { fg = colors.bg, bg = colors.orange })

	-- Selección visual
	set_hl("Visual", { bg = colors.hover_bg })
	set_hl("VisualNOS", { link = "Visual" }) -- Enlazar a Visual

	-- Popups (menús de completado, etc.)
	set_hl("Pmenu", { fg = colors.fg, bg = actual_bg_highlight })
	set_hl("PmenuSel", { fg = colors.fg, bg = colors.hover_bg })
	set_hl("PmenuSbar", { bg = actual_bg_highlight })
	set_hl("PmenuThumb", { fg = colors.border })
	set_hl("PmenuKind", { fg = colors.cyan })
	set_hl("PmenuKindSel", { fg = colors.cyan, bg = colors.hover_bg })
	set_hl("PmenuExtra", { fg = colors.comment })
	set_hl("PmenuExtraSel", { fg = colors.comment, bg = colors.hover_bg })

	-- Wildmenu (completado de comandos)
	set_hl("WildMenu", { fg = colors.fg, bg = colors.hover_bg })

	-- Pestañas
	set_hl("TabLine", { fg = colors.tab_inactive_fg, bg = colors.tab_inactive_bg })
	set_hl("TabLineFill", { bg = actual_bg })
	set_hl("TabLineSel", { fg = colors.tab_active_fg, bg = colors.tab_active_bg })

	-- Barra de estado
	set_hl("StatusLine", { fg = colors.fg, bg = actual_bg })
	set_hl("StatusLineNC", { fg = colors.comment, bg = actual_bg_highlight })

	-- Separadores de ventana
	set_hl("WinSeparator", { fg = colors.border })
	set_hl("VertSplit", { link = "WinSeparator" }) -- Enlazar a WinSeparator

	-- Plegado de código (folding)
	set_hl("Folded", { fg = colors.comment, bg = actual_bg_highlight })
	set_hl("FoldColumn", { fg = colors.comment })

	-- Mensajes
	set_hl("ErrorMsg", { fg = colors.error })
	set_hl("WarningMsg", { fg = colors.warning })
	set_hl("ModeMsg", { fg = colors.fg })
	set_hl("MoreMsg", { fg = colors.green })
	set_hl("Question", { fg = colors.blue })

	-- Diagnósticos (LSP)
	set_hl("DiagnosticError", { fg = colors.error })
	set_hl("DiagnosticWarn", { fg = colors.warning })
	set_hl("DiagnosticInfo", { fg = colors.info })
	set_hl("DiagnosticHint", { fg = colors.hint })
	set_hl("DiagnosticOk", { fg = colors.green })

	set_hl("DiagnosticUnderlineError", { sp = colors.error, undercurl = true })
	set_hl("DiagnosticUnderlineWarn", { sp = colors.warning, undercurl = true })
	set_hl("DiagnosticUnderlineInfo", { sp = colors.info, undercurl = true })
	set_hl("DiagnosticUnderlineHint", { sp = colors.hint, undercurl = true })
	set_hl("DiagnosticUnderlineOk", { sp = colors.green, undercurl = true })

	set_hl("DiagnosticVirtualTextError", { fg = colors.error, bg = colors.red_dim })
	set_hl("DiagnosticVirtualTextWarn", { fg = colors.warning, bg = colors.orange_dim })
	set_hl("DiagnosticVirtualTextInfo", { fg = colors.info, bg = colors.blue_dim })
	set_hl("DiagnosticVirtualTextHint", { fg = colors.hint, bg = colors.green_dim })

	-- Diff
	set_hl("DiffAdd", { bg = colors.diff_add })
	set_hl("DiffChange", { bg = colors.diff_change })
	set_hl("DiffDelete", { bg = colors.diff_delete })
	set_hl("DiffText", { bg = colors.diff_text })

	-- Git gutter / GitSigns
	set_hl("GitGutterAdd", { fg = colors.gutter_added })
	set_hl("GitGutterChange", { fg = colors.gutter_modified })
	set_hl("GitGutterDelete", { fg = colors.gutter_deleted })
	set_hl("GitGutterChangeDelete", { fg = colors.gutter_modified }) -- Consistencia
	link_hl("GitSignsAdd", "GitGutterAdd")
	link_hl("GitSignsChange", "GitGutterChange")
	link_hl("GitSignsDelete", "GitGutterDelete")

	-- Spell checking
	set_hl("SpellBad", { sp = colors.error, undercurl = true })
	set_hl("SpellCap", { sp = colors.warning, undercurl = true })
	set_hl("SpellRare", { sp = colors.info, undercurl = true })
	set_hl("SpellLocal", { sp = colors.info, undercurl = true })

	-- Espacios en blanco y texto no visible
	set_hl("Whitespace", { fg = colors.whitespace })
	set_hl("NonText", { link = "Whitespace" }) -- Enlazar a Whitespace
	set_hl("SpecialKey", { link = "Whitespace" })

	-- Coincidencia de paréntesis
	set_hl("MatchParen", { bg = colors.bracket_match_bg, fg = colors.fg, bold = true })

	-- **Sintaxis general y enlaces (ahora mejor organizados)**
	-- Definiciones explícitas primero, luego enlaces
	set_hl("Comment", { fg = colors.comment, italic = opts.italic_comments }) -- Usa opción de comentario itálico

	set_hl("String", { fg = colors.green })
	set_hl("Character", { link = "String" })
	set_hl("Number", { fg = colors.yellow })
	set_hl("Boolean", { fg = colors.cyan })
	set_hl("Float", { link = "Number" })

	set_hl("Function", { fg = colors.cyan, bold = opts.bold_functions }) -- Usa opción de función negrita
	set_hl("Identifier", { fg = colors.fg }) -- Mantener como fg si es la intención principal

	set_hl("Statement", { fg = colors.red })
	set_hl("Conditional", { link = "Statement" })
	set_hl("Repeat", { link = "Statement" })
	set_hl("Label", { fg = colors.cyan }) -- Tu color original
	set_hl("Operator", { fg = colors.blue })
	set_hl("Keyword", { link = "Statement" }) -- Tu color original es Statement
	set_hl("Exception", { fg = colors.cyan })

	set_hl("PreProc", { fg = colors.cyan })
	set_hl("Include", { link = "PreProc" }) -- Puedes enlazar
	set_hl("Define", { fg = colors.blue })
	set_hl("Macro", { link = "Define" }) -- Puedes enlazar
	set_hl("PreCondit", { link = "PreProc" }) -- Puedes enlazar

	set_hl("Type", { fg = colors.blue })
	set_hl("StorageClass", { fg = colors.red }) -- Tu color original
	set_hl("Structure", { fg = colors.yellow }) -- Tu color original
	set_hl("Typedef", { link = "Structure" }) -- Puedes enlazar

	set_hl("Special", { fg = colors.fg })
	set_hl("SpecialChar", { link = "Special" }) -- Enlazar a Special
	set_hl("Tag", { fg = colors.red })
	set_hl("Delimiter", { fg = colors.fg })
	set_hl("SpecialComment", { fg = colors.comment, italic = opts.italic_comments })
	set_hl("Debug", { fg = colors.orange })

	set_hl("Underlined", { underline = true })
	set_hl("Ignore", { fg = colors.comment })
	set_hl("Error", { fg = colors.error })
	set_hl("Todo", { fg = colors.yellow, bold = true })

	-- **Treesitter highlights (con enlaces a tus definiciones estándar o colores directos)**
	-- Mantengo tus definiciones existentes, agrupando y añadiendo 'link' donde sea lógico.
	set_hl("@comment", { link = "Comment" })
	set_hl("@comment.documentation", { link = "Comment" }) -- Mantener coherencia con Comment

	set_hl("@error", { link = "Error" })
	set_hl("@none", { bg = colors.none, fg = colors.none }) -- Correcto para 'none'
	set_hl("@preproc", { link = "PreProc" })
	set_hl("@define", { link = "Define" })
	set_hl("@operator", { link = "Operator" })

	set_hl("@punctuation.delimiter", { fg = colors.fg })
	set_hl("@punctuation.bracket", { fg = colors.fg })
	set_hl("@punctuation.special", { fg = colors.fg })

	set_hl("@string", { link = "String" })
	set_hl("@string.documentation", { fg = colors.green, italic = true })
	set_hl("@string.regex", { fg = colors.orange })
	set_hl("@string.escape", { fg = colors.orange })
	set_hl("@string.special", { fg = colors.orange })

	set_hl("@character", { link = "Character" })
	set_hl("@character.special", { fg = colors.orange })

	set_hl("@boolean", { link = "Boolean" })
	set_hl("@number", { link = "Number" })
	set_hl("@number.float", { link = "Float" })

	set_hl("@function", { link = "Function" })
	set_hl("@function.builtin", { fg = colors.cyan }) -- Tu color original
	set_hl("@function.call", { fg = colors.cyan })
	set_hl("@function.macro", { fg = colors.blue })

	set_hl("@method", { fg = colors.cyan })
	set_hl("@method.call", { fg = colors.cyan })
	set_hl("@constructor", { fg = colors.yellow })

	set_hl("@parameter", { fg = colors.fg })
	set_hl("@parameter.builtin", { fg = colors.orange })
	set_hl("@parameter.reference", { fg = colors.fg })

	set_hl("@field", { fg = colors.fg })
	set_hl("@property", { fg = colors.fg })

	set_hl("@variable", { fg = colors.fg })
	set_hl("@variable.builtin", { fg = colors.orange })
	set_hl("@variable.parameter", { fg = colors.fg })
	set_hl("@variable.member", { fg = colors.fg })

	set_hl("@constant", { fg = colors.fg })
	set_hl("@constant.builtin", { fg = colors.cyan })
	set_hl("@constant.macro", { fg = colors.blue })

	set_hl("@namespace", { fg = colors.yellow })
	set_hl("@module", { fg = colors.yellow })

	set_hl("@symbol", { fg = colors.fg })

	set_hl("@text", { fg = colors.fg })
	set_hl("@text.literal", { fg = colors.green })
	set_hl("@text.reference", { fg = colors.blue })
	set_hl("@text.title", { fg = colors.yellow, bold = true })
	set_hl("@text.uri", { fg = colors.blue, underline = true })
	set_hl("@text.underline", { underline = true })
	set_hl("@text.todo", { fg = colors.yellow, bold = true })
	set_hl("@text.note", { fg = colors.info, bold = true })
	set_hl("@text.warning", { fg = colors.warning, bold = true })
	set_hl("@text.danger", { fg = colors.error, bold = true })

	set_hl("@markup.strong", { bold = true })
	set_hl("@markup.italic", { italic = true })
	set_hl("@markup.strikethrough", { strikethrough = true })
	set_hl("@markup.underline", { underline = true })
	set_hl("@markup.heading", { fg = colors.yellow, bold = true })
	set_hl("@markup.raw", { fg = colors.green })
	set_hl("@markup.link", { fg = colors.blue })
	set_hl("@markup.link.url", { fg = colors.blue, underline = true })
	set_hl("@markup.link.label", { fg = colors.cyan })
	set_hl("@markup.list", { fg = colors.red })
	set_hl("@markup.list.checked", { fg = colors.green })
	set_hl("@markup.list.unchecked", { fg = colors.comment })

	set_hl("@tag", { fg = colors.red })
	set_hl("@tag.attribute", { fg = colors.yellow })
	set_hl("@tag.delimiter", { fg = colors.fg })

	set_hl("@keyword", { link = "Keyword" })
	set_hl("@keyword.coroutine", { fg = colors.red })
	set_hl("@keyword.function", { fg = colors.red })
	set_hl("@keyword.operator", { fg = colors.blue })
	set_hl("@keyword.import", { fg = colors.red })
	set_hl("@keyword.type", { fg = colors.red })
	set_hl("@keyword.modifier", { fg = colors.red })
	set_hl("@keyword.repeat", { fg = colors.red })
	set_hl("@keyword.return", { fg = colors.red })
	set_hl("@keyword.debug", { fg = colors.orange })
	set_hl("@keyword.exception", { fg = colors.cyan })
	set_hl("@keyword.conditional", { fg = colors.red })
	set_hl("@keyword.conditional.ternary", { fg = colors.blue })
	set_hl("@keyword.directive", { fg = colors.cyan })
	set_hl("@keyword.directive.define", { fg = colors.blue })

	set_hl("@conditional", { link = "Conditional" })
	set_hl("@conditional.ternary", { fg = colors.blue })
	set_hl("@repeat", { link = "Repeat" })
	set_hl("@label", { link = "Label" })
	set_hl("@include", { link = "Include" })
	set_hl("@exception", { link = "Exception" })

	set_hl("@type", { link = "Type" })
	set_hl("@type.builtin", { fg = colors.blue })
	set_hl("@type.definition", { fg = colors.blue })
	set_hl("@type.qualifier", { fg = colors.red })

	set_hl("@storageclass", { link = "StorageClass" })
	set_hl("@attribute", { fg = colors.yellow })
	set_hl("@annotation", { fg = colors.yellow })

	-- LSP semantic tokens
	set_hl("@lsp.type.class", { fg = colors.yellow })
	set_hl("@lsp.type.decorator", { fg = colors.yellow })
	set_hl("@lsp.type.enum", { fg = colors.yellow })
	set_hl("@lsp.type.enumMember", { fg = colors.cyan })
	set_hl("@lsp.type.function", { fg = colors.cyan })
	set_hl("@lsp.type.interface", { fg = colors.yellow })
	set_hl("@lsp.type.macro", { fg = colors.blue })
	set_hl("@lsp.type.method", { fg = colors.cyan })
	set_hl("@lsp.type.namespace", { fg = colors.yellow })
	set_hl("@lsp.type.parameter", { fg = colors.fg })
	set_hl("@lsp.type.property", { fg = colors.fg })
	set_hl("@lsp.type.struct", { fg = colors.yellow })
	set_hl("@lsp.type.type", { fg = colors.blue })
	set_hl("@lsp.type.typeParameter", { fg = colors.yellow })
	set_hl("@lsp.type.variable", { fg = colors.fg })

	-- Plugin specific highlights (los mantengo tal cual los tenías, son muy completos)
	-- Telescope
	set_hl("TelescopeNormal", { fg = colors.fg, bg = actual_bg })
	set_hl("TelescopeBorder", { fg = colors.border, bg = actual_bg })
	set_hl("TelescopePromptNormal", { fg = colors.fg, bg = actual_bg_highlight })
	set_hl("TelescopePromptBorder", { fg = colors.border, bg = actual_bg_highlight })
	set_hl("TelescopePromptTitle", { fg = colors.fg, bg = actual_bg_highlight })
	set_hl("TelescopePreviewTitle", { fg = colors.fg, bg = actual_bg })
	set_hl("TelescopeResultsTitle", { fg = colors.fg, bg = actual_bg })
	set_hl("TelescopeSelection", { fg = colors.fg, bg = colors.hover_bg })
	set_hl("TelescopeSelectionCaret", { fg = colors.red, bg = colors.hover_bg })
	set_hl("TelescopeMultiSelection", { fg = colors.fg, bg = colors.hover_bg })
	set_hl("TelescopeMatching", { fg = colors.yellow, bold = true })

	-- Neo-tree
	set_hl("NeoTreeNormal", { fg = colors.fg, bg = colors.sidebar_bg })
	set_hl("NeoTreeNormalNC", { fg = colors.fg, bg = colors.sidebar_bg })
	set_hl("NeoTreeDirectoryName", { fg = colors.fg })
	set_hl("NeoTreeDirectoryIcon", { fg = colors.gutter_added })
	set_hl("NeoTreeFileName", { fg = colors.fg })
	set_hl("NeoTreeFileIcon", { fg = colors.blue })
	set_hl("NeoTreeIndentMarker", { fg = colors.indent_guide })
	set_hl("NeoTreeExpander", { fg = colors.comment })
	set_hl("NeoTreeGitAdded", { fg = colors.gutter_added })
	set_hl("NeoTreeGitDeleted", { fg = colors.gutter_deleted })
	set_hl("NeoTreeGitModified", { fg = colors.gutter_modified })
	set_hl("NeoTreeGitConflict", { fg = colors.warning })
	set_hl("NeoTreeGitUntracked", { fg = colors.comment })
	set_hl("NeoTreeGitIgnored", { fg = colors.comment })
	set_hl("NeoTreeGitStaged", { fg = colors.green })
	set_hl("NeoTreeGitUnstaged", { fg = colors.orange })

	-- Which-key
	set_hl("WhichKey", { fg = colors.cyan })
	set_hl("WhichKeyGroup", { fg = colors.blue })
	set_hl("WhichKeyDesc", { fg = colors.fg })
	set_hl("WhichKeySeperator", { fg = colors.comment })
	set_hl("WhichKeyFloat", { bg = actual_bg_highlight })
	set_hl("WhichKeyBorder", { fg = colors.border })

	-- Notify
	set_hl("NotifyERRORBorder", { fg = colors.error })
	set_hl("NotifyWARNBorder", { fg = colors.warning })
	set_hl("NotifyINFOBorder", { fg = colors.info })
	set_hl("NotifyDEBUGBorder", { fg = colors.comment })
	set_hl("NotifyTRACEBorder", { fg = colors.hint })
	set_hl("NotifyERRORIcon", { fg = colors.error })
	set_hl("NotifyWARNIcon", { fg = colors.warning })
	set_hl("NotifyINFOIcon", { fg = colors.info })
	set_hl("NotifyDEBUGIcon", { fg = colors.comment })
	set_hl("NotifyTRACEIcon", { fg = colors.hint })
	set_hl("NotifyERRORTitle", { fg = colors.error })
	set_hl("NotifyWARNTitle", { fg = colors.warning })
	set_hl("NotifyINFOTitle", { fg = colors.info })
	set_hl("NotifyDEBUGTitle", { fg = colors.comment })
	set_hl("NotifyTRACETitle", { fg = colors.hint })
	set_hl("NotifyERRORBody", { fg = colors.fg })
	set_hl("NotifyWARNBody", { fg = colors.fg })
	set_hl("NotifyINFOBody", { fg = colors.fg })
	set_hl("NotifyDEBUGBody", { fg = colors.fg })
	set_hl("NotifyTRACEBody", { fg = colors.fg })

	-- Indent Blankline
	set_hl("IblIndent", { fg = colors.indent_guide })
	set_hl("IblScope", { fg = colors.border })

	-- Noice
	set_hl("NoicePopup", { bg = actual_bg_highlight })
	set_hl("NoicePopupBorder", { fg = colors.border })
	set_hl("NoiceCmdlinePopup", { bg = actual_bg_highlight })
	set_hl("NoiceCmdlinePopupBorder", { fg = colors.border })
	set_hl("NoiceCmdlineIcon", { fg = colors.cyan })
	set_hl("NoiceConfirm", { bg = actual_bg_highlight })
	set_hl("NoiceConfirmBorder", { fg = colors.border })

	-- Lazy
	set_hl("LazyNormal", { bg = actual_bg })
	set_hl("LazyButton", { bg = actual_bg_highlight })
	set_hl("LazyButtonActive", { bg = colors.hover_bg })
	set_hl("LazyComment", { fg = colors.comment })
	set_hl("LazyCommit", { fg = colors.comment })
	set_hl("LazyCommitIssue", { fg = colors.red })
	set_hl("LazyCommitScope", { fg = colors.cyan })
	set_hl("LazyCommitType", { fg = colors.blue })
	set_hl("LazyDimmed", { fg = colors.comment })
	set_hl("LazyDir", { fg = colors.blue })
	set_hl("LazyH1", { fg = colors.yellow, bold = true })
	set_hl("LazyH2", { fg = colors.cyan, bold = true })
	set_hl("LazyLocal", { fg = colors.green })
	set_hl("LazyProgressDone", { fg = colors.green })
	set_hl("LazyProgressTodo", { fg = colors.comment })
	set_hl("LazyProp", { fg = colors.orange })
	set_hl("LazyReasonCmd", { fg = colors.yellow })
	set_hl("LazyReasonEvent", { fg = colors.cyan })
	set_hl("LazyReasonFt", { fg = colors.green })
	set_hl("LazyReasonImport", { fg = colors.blue })
	set_hl("LazyReasonKeys", { fg = colors.orange })
	set_hl("LazyReasonPlugin", { fg = colors.red })
	set_hl("LazyReasonRuntime", { fg = colors.magenta })
	set_hl("LazyReasonSource", { fg = colors.cyan })
	set_hl("LazyReasonStart", { fg = colors.green })
	set_hl("LazySpecial", { fg = colors.orange })
	set_hl("LazyTaskError", { fg = colors.error })
	set_hl("LazyTaskOutput", { fg = colors.fg })
	set_hl("LazyUrl", { fg = colors.blue, underline = true })
	set_hl("LazyValue", { fg = colors.green })

	-- Mason
	set_hl("MasonHeader", { fg = colors.bg, bg = colors.cyan, bold = true })
	set_hl("MasonHeaderSecondary", { fg = colors.bg, bg = colors.blue, bold = true })
	set_hl("MasonHighlight", { fg = colors.cyan })
	set_hl("MasonHighlightBlock", { fg = colors.bg, bg = colors.cyan })
	set_hl("MasonHighlightBlockBold", { fg = colors.bg, bg = colors.cyan, bold = true })
	set_hl("MasonHighlightSecondary", { fg = colors.blue })
	set_hl("MasonHighlightBlockSecondary", { fg = colors.bg, bg = colors.blue })
	set_hl("MasonHighlightBlockBoldSecondary", { fg = colors.bg, bg = colors.blue, bold = true })
	set_hl("MasonMuted", { fg = colors.comment })
	set_hl("MasonMutedBlock", { fg = colors.comment, bg = actual_bg_highlight })
	set_hl("MasonMutedBlockBold", { fg = colors.comment, bg = actual_bg_highlight, bold = true })

	-- Cmp
	set_hl("CmpItemAbbrDeprecated", { fg = colors.comment, strikethrough = true })
	set_hl("CmpItemAbbrMatch", { fg = colors.yellow, bold = true })
	set_hl("CmpItemAbbrMatchFuzzy", { fg = colors.yellow, bold = true })
	set_hl("CmpItemKind", { fg = colors.cyan })
	set_hl("CmpItemKindVariable", { fg = colors.fg })
	set_hl("CmpItemKindInterface", { fg = colors.yellow })
	set_hl("CmpItemKindText", { fg = colors.fg })
	set_hl("CmpItemKindFunction", { fg = colors.cyan })
	set_hl("CmpItemKindMethod", { fg = colors.cyan })
	set_hl("CmpItemKindKeyword", { fg = colors.red })
	set_hl("CmpItemKindProperty", { fg = colors.fg })
	set_hl("CmpItemKindUnit", { fg = colors.orange })
	set_hl("CmpItemKindConstructor", { fg = colors.yellow })
	set_hl("CmpItemKindClass", { fg = colors.yellow })
	set_hl("CmpItemKindModule", { fg = colors.yellow })
	set_hl("CmpItemKindOperator", { fg = colors.blue })
	set_hl("CmpItemKindReference", { fg = colors.orange })
	set_hl("CmpItemKindEnum", { fg = colors.yellow })
	set_hl("CmpItemKindEnumMember", { fg = colors.cyan })
	set_hl("CmpItemKindStruct", { fg = colors.yellow })
	set_hl("CmpItemKindValue", { fg = colors.green })
	set_hl("CmpItemKindEvent", { fg = colors.orange })
	set_hl("CmpItemKindFile", { fg = colors.blue })
	set_hl("CmpItemKindFolder", { fg = colors.blue })
	set_hl("CmpItemKindColor", { fg = colors.green })
	set_hl("CmpItemKindConstant", { fg = colors.cyan })
	set_hl("CmpItemKindSnippet", { fg = colors.green })
	set_hl("CmpItemKindTypeParameter", { fg = colors.yellow })

	-- Dashboard
	set_hl("DashboardShortCut", { fg = colors.cyan })
	set_hl("DashboardHeader", { fg = colors.blue })
	set_hl("DashboardCenter", { fg = colors.green })
	set_hl("DashboardFooter", { fg = colors.comment })

	-- Alpha
	set_hl("AlphaShortcut", { fg = colors.cyan })
	set_hl("AlphaHeader", { fg = colors.blue })
	set_hl("AlphaHeaderLabel", { fg = colors.orange })
	set_hl("AlphaFooter", { fg = colors.comment })
	set_hl("AlphaButtons", { fg = colors.green })

	-- Trouble
	set_hl("TroubleText", { fg = colors.fg })
	set_hl("TroubleCount", { fg = colors.red, bg = actual_bg_highlight })
	set_hl("TroubleNormal", { fg = colors.fg, bg = actual_bg })

	-- Lualine
	set_hl("lualine_a_normal", { fg = colors.bg, bg = colors.blue, bold = true })
	set_hl("lualine_a_insert", { fg = colors.bg, bg = colors.green, bold = true })
	set_hl("lualine_a_visual", { fg = colors.bg, bg = colors.magenta, bold = true })
	set_hl("lualine_a_replace", { fg = colors.bg, bg = colors.red, bold = true })
	set_hl("lualine_a_command", { fg = colors.bg, bg = colors.yellow, bold = true })
	set_hl("lualine_b_normal", { fg = colors.fg, bg = actual_bg_highlight })
	set_hl("lualine_c_normal", { fg = colors.fg, bg = actual_bg })

	-- Puedes seguir añadiendo más highlights de plugins aquí.
end

return M
