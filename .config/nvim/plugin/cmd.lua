local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Run gofmt + goimport on save
autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = { only = { "source.organizeImports" } }
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				end
			end
		end
		vim.lsp.buf.format({ async = false })
	end
})

local numbertoggle = augroup("numbertoggle", {})
autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
	callback = function()
		if vim.wo.number and vim.fn.mode() ~= "i" then
			vim.wo.relativenumber = true
		end
	end,
	group = numbertoggle,
})
autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
	callback = function()
		if vim.wo.number then
			vim.wo.relativenumber = false
		end
	end,
	group = numbertoggle,
})

autocmd('FileType', {
	pattern = { "go", "js", "vim", "lua" },
	callback = function()
		vim.api.nvim_set_option_value("colorcolumn", "81", { scope = "local" })
	end,
})

local yank_group = augroup('HighlightYank', {})
autocmd('TextYankPost', {
	group = yank_group,
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({
			higroup = 'Search',
			timeout = 100,
		})
	end,
})
