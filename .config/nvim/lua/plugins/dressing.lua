return {
  {
    "stevearc/dressing.nvim",
    lazy = false,
    config = function()
      require('dressing').setup({
        input = {
          win_options = {
            winblend = 0,
          },
          start_in_insert = false,
          get_config = function(opts)
            if opts.kind == 'grep' then
              return {
                insert_only = true,
                start_in_insert = true,
                relative = "editor",
              }
            end
          end
        },
        select = {
          trim_prompt = false,
        },
      })
    end,
  },
}
