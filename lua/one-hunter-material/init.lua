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

-- Utility: convert hex string to decimal RGB integer
local function hex_to_rgbnum(hex)
	if type(hex) ~= "string" or hex:sub(1, 1) ~= "#" then
		return nil
	end
	local h = hex:gsub("#", ""):sub(1, 6)
	local r = tonumber(h:sub(1, 2), 16)
	local g = tonumber(h:sub(3, 4), 16)
	local b = tonumber(h:sub(5, 6), 16)
	return r * 256 * 256 + g * 256 + b
end

-- Apply highlights by converting hex to numerical RGB where needed
local function apply_hl(group, style)
	-- Prepare a shallow copy to not mutate original
	local s = {}
	for k, v in pairs(style) do
		if (k == "fg" or k == "bg" or k == "sp") and type(v) == "string" and v:sub(1, 1) == "#" then
			s[k] = hex_to_rgbnum(v)
		else
			s[k] = v
		end
	end
	vim.api.nvim_set_hl(0, group, s)
end

-- Generate highlights
local function setup_highlights()
	local hl = {
		Normal = { fg = colors.fg, bg = colors.bg },
		-- ... (otros grupos idénticos) ...
		Todo = { fg = colors.yellow, bold = true },
	}

	for group, style in pairs(hl) do
		local ok, err = pcall(apply_hl, group, style)
		if not ok then
			vim.notify(string.format("one-hunter-material error setting hl %s: %s", group, err), vim.log.levels.ERROR)
		end
	end
end

-- Setup function called by LazyVim
function M.setup(opts)
	opts = vim.tbl_deep_extend("force", default_opts, opts or {})
	vim.o.termguicolors = true
	vim.cmd("hi clear")

	if opts.transparent_background then
		colors.bg = colors.none
		colors.cursor_line = colors.none
		colors.bg_highlight = colors.none
	end

	setup_highlights()
	vim.g.colors_name = "one-hunter-material"
end

return M
