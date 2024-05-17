local lspkind = require "lspkind"
lspkind.init()

local cmp = require "cmp"

cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  preselect = cmp.PreselectMode.None,
  mapping = {
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<c-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),
  },

  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = 'buffer' },
    { name = 'nvim_lsp_signature_help' },
  },

  ---@diagnostic disable-next-line: missing-fields
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        path = "[path]",
        luasnip = "[snip]",
      },
    },
  },

}

cmp.setup.filetype({ 'mysql', 'sql' }, {
  sources = cmp.config.sources({
    { name = "vim-dadbod-completion" },
    { name = "buffer" },
  }),
  ---@diagnostic disable-next-line: missing-fields
  formatting = {
    format = function(entry, vim_item)
      if (entry.source.name == 'buffer') then
        vim_item.menu = "[buf]"
        return vim_item
      end
      vim_item.menu = "[DB]"
      return vim_item
    end
  },
})

local ls = require "luasnip"
ls.config.set_config {
  history = false,
  updateevents = "TextChanged,TextChangedI",
}

require("luasnip.loaders.from_vscode").lazy_load()

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
