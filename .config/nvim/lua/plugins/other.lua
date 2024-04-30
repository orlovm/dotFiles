return {
  {
    "shortcuts/no-neck-pain.nvim",
    version = "v1.7.0",
  },

  {
    "mfussenegger/nvim-dap",
  },
  {
    "leoluz/nvim-dap-go",
  },
  {
    "rcarriga/nvim-dap-ui",
  },


  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = false,
  },
  {
    "nvim-neotest/nvim-nio",
  },
  {
    "ray-x/go.nvim",
    lazy = false,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = false,
  },
  {
    "hrsh7th/cmp-cmdline",
    lazy = false,
  },
  {
    "b0o/schemastore.nvim",
    lazy = false,
  },

  {
    "hrsh7th/cmp-nvim-lua",
    lazy = false,
  },
  {
    "hrsh7th/cmp-buffer",
    lazy = false,
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
  },
  {
    "hrsh7th/cmp-path",
    lazy = false,
  },
  {
    "tamago324/cmp-zsh",
    lazy = false,
  },
  {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    lazy = false,
  },
  {
    "onsails/lspkind-nvim",
    lazy = false,
  },
  {
    "nvim-lua/lsp_extensions.nvim",
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = false,
  },

  {
    "L3MON4D3/LuaSnip",
    lazy = false,
  },
  {
    "rafamadriz/friendly-snippets",
    lazy = false,
  },
  {
    "saadparwaiz1/cmp_luasnip",
    lazy = false,
  },
  {
    "gorkunov/smartpairs.vim",
  },

  {
    "chrisbra/color_highlight",
    lazy = false,
  },

  {
    "jsborjesson/vim-uppercase-sql",
    lazy = false,
  },

  {
    "kana/vim-textobj-user",
    lazy = false,
  },
  {
    "fvictorio/vim-textobj-backticks",
    lazy = false,
    dependencies = {
      "kana/vim-textobj-user",
    },
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }
    }
  },
  {
    "zbirenbaum/copilot-cmp",
    lazy = false,
  },
  {
    "tzachar/highlight-undo.nvim",
    config = function()
      require("highlight-undo").setup()
    end,
  },
}
