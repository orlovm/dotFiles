local M = {}

local lsp_util = vim.lsp.util

function M.code_action_listener1()
 local params = vim.lsp.util.make_range_params() -- get params for current position
    params.context = {
        diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
    }

    local results, err = vim.lsp.buf_request_sync(
        0, -- current buffer
        "textDocument/codeAction", -- get code actions
        params,
        900
    )

    if err then return end

    if not results or vim.tbl_isempty(results) then
        return
    end

    -- we have an action!
    for cid, resp in pairs(results) do
        if resp.result then
                  print "CODEACTION!"
        end 
    end

end

return M
