return {
  {
    "shortcuts/no-neck-pain.nvim",
    opts = {
      mappings = {
        enabled = false,
      },
      width = 132,
      minSideBufferWidth = 30,
      autocmds = {
        enableOnVimEnter = true,
        enableOnTabEnter = true,
        reloadOnColorSchemeChange = true,
        skipEnteringNoNeckPainBuffer = true,
      },
    },
    init = function()
      -- nnp has an odd colors setup, so set it up here
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'no-neck-pain',
        callback = function()
          vim.cmd('highlight NNPBackground guibg=#252525 guifg=#252525')
          vim.opt_local.winhighlight =
          'Normal:NNPBackground,VertSplit:NNPBackground'
        end,
      })
    end,
  },
}
