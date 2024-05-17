local parsers = {

  "proto",
  "go",
  "lua",
  "javascript",
  "vim",
  "python",
  "vue",
  "comment",
  'yaml',
  "json",
  "bash",
  "dockerfile",
  "gomod",
  "regex",
  "http",
  "regex",
  "markdown",
  "markdown_inline",
  "toml",
  "ruby",
  "sql",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = parsers,

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        indent = {
          enable = true
        },

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = enable,
          keymaps = {
            -- mappings for incremental selection (visual mappings)
            init_selection = "gnn",    -- maps in normal mode to init the node/scope selection
            node_incremental = "grn",  -- increment to the upper named parent
            scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
            node_decremental = "grm"   -- decrement to the previous node
          }
        },

        textobjects = {
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]A"] = "@parameter.inner",
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[a"] = "@parameter.inner",
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ['ia'] = "@parameter.inner",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
              ["<leader>m"] = "@function.outer",
              ["<leader>["] = "@class.outer"
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
              ["<leader>M"] = "@function.outer",
              ["<leader>]"] = "@class.outer"
            },
          },
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
}
