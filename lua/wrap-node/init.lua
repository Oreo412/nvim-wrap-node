local M = {}

M.handlers = {}

M.handlers.rust = function(node, type, parent)
	if t == "type_identifier" or t == "type_arguments" then
		if parent and parent:type() == "generic_type" then
			node = parent
		end
		left, right = "<", ">"
	else
		if parent and parent:type() == "scoped_identifier" then
			node = parent
		end
		left, right = "(", ")"
	end
	return node, left, right
end

function M.wrap_node()
	if not vim.bo.modifiable then
		return
	end

	local ok, parser = pcall(vim.treesitter.get_parser, 0)
	if not ok or not parser then
		return
	end

	parser:parse()

	local node = vim.treesitter.get_node()
	if not node then
		return
	end

	local ft = vim.bo.filetype
	local handler = M.handlers[ft]

	local left, right

	if handler then
		node, left, right = handler(node)
	else
		left, right = "(", ")"
	end

	if not node then
		return
	end

	local text = vim.treesitter.get_node_text(node, 0)

	if type(text) == "table" then
		text = table.concat(text, "\n")
	end

	vim.api.nvim_buf_set_text(0, sr, sc, er, ec, { left .. text .. right })
	vim.api.nvim_win_set_cursor(0, { sr + 1, sc })
	vim.cmd("startinsert")
end

function M.setup(opts)
	opts = opts or {}
	if opts.handlers then
		M.handlers = vim.tbl_extend("force", M.handlers, opts.handlers)
	end
end

return M
