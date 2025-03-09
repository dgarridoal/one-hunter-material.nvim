local M = {}

function M.setup(opts)
	-- Merge default options with user options
	opts = opts or {}

	-- Load the colorscheme
	require("one-hunter-material.colors").setup()
end

return M
