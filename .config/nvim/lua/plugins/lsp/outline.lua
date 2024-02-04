return {
	"simrat39/symbols-outline.nvim",
	keys = { { "<leader>co", "<cmd>SymbolsOutline<cr>", desc = "code_outline" } },
	opts = {
		auto_preview = false,
		width = 20,
		auto_unfold_hover = false,
		relative_width = true,
		keymaps = { -- These keymaps can be a string or a table for multiple keys
			close = { "<Esc>", "q" },
			goto_location = "<Cr>",
			focus_location = "o",
			hover_symbol = "<C-space>",
			toggle_preview = "p",
			rename_symbol = "r",
			code_actions = "a",
			fold = "<tab>",
			unfold = "l",
			fold_all = "W",
			unfold_all = "E",
			fold_reset = "R",
		},
		lsp_blacklist = {},
		symbol_blacklist = {},
	},
}
