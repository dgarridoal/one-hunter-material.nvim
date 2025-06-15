-- lua/mi_colorscheme/init.lua

-- MiColorscheme: One Hunter Material

-- Carga tus opciones por defecto y la función para aplicar highlights
local default_opts = {
	transparent_background = false,
	italic_comments = true,
	bold_functions = true,
}
local highlight = require("mi_colorscheme.highlight")

-- Define la tabla principal del colorscheme
local M = {}

-- Función de setup llamada por LazyVim o directamente con `:colorscheme`
function M.setup(opts)
	-- Combina las opciones de usuario con las opciones por defecto
	opts = vim.tbl_deep_extend("force", default_opts, opts or {})

	-- Asegúrate de que termguicolors esté activado para usar colores True Color
	vim.o.termguicolors = true

	-- Aplica todos los highlights
	highlight.apply_highlights(opts)

	-- Establece el nombre global del colorscheme de Neovim
	vim.g.colors_name = "one-hunter-material"
end

-- Llama a la función de setup directamente al cargar el módulo.
-- Esto asegura que el colorscheme se aplique cuando LazyVim lo carga.
M.setup()

return M
