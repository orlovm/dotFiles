require('dressing').setup({
        input = {
                winblend = 0,
                get_config = function(opts)
                  if opts.kind == 'grep' then
                    return {
                      insert_only = true,
                      relative = "editor",
                    }
                  end
                end
        },
        select = {
                trim_prompt = false,
        },
})
