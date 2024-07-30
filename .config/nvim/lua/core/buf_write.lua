-- vim: foldmethod=marker
-- vim: foldlevel=0
--{{{
augroup("hotreload", { clear = true })
local file_actions = {}

local function post_act(filename, action)
	file_actions[filename] = action
	local patterns = vim.tbl_keys(file_actions)

	autocmd("BufWritePost", {
		group = "hotreload",
		pattern = patterns,
		callback = function()
			local filename = vim.fn.expand("%:t")
			local action = file_actions[filename]
			if action then
				action()
			end
		end,
	})
end
--}}}

-- lua dir source
post_act("*/ftplugin/*.lua", function()
	vim.cmd("silent source%")
end)

post_act("*/core/*.lua", function()
	vim.cmd("silent source%")
end)

-- tmux hot reload
post_act("tmux.conf", function()
	vim.cmd("silent !tmux source /Users/suvasanketrout/.config/tmux/tmux.conf")
end)

-- aerospace hot reload
post_act("aerospace.toml", function()
	vim.cmd("silent !aerospace reload-config")
end)

-- abolish hot reload
post_act("abolish.lua", function()
	vim.fn.timer_start(2000, function()
		vim.cmd("silent Lazy reload vim-abolish")
	end)
end)

-- lualine hotreload
post_act("statusline.lua", function()
	vim.fn.timer_start(2000, function()
		vim.cmd("silent Lazy reload lualine.nvim")
	end)
end)
