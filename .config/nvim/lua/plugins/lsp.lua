local disabled_go_linters = {
  "deadcode",
  "scopelint",
  "nlreturn",
  "varcheck",
  "ifshort",
  "interfacer",
  "structcheck",
  "maligned",
  "nosnakecase",
  "golint",
  "tagliatelle",
  "varnamelen",
  "lll",
  "exhaustruct",
  "exhaustivestruct",
  "typecheck",
  "wrapcheck",
  "godox",
  "depguard",
  "ireturn",
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/neodev.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "b0o/SchemaStore.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      -- "stevearc/conform.nvim",
    },
    config = function()
      require("neodev").setup()

      local capabilities = nil
      if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      end

      local lspconfig = require "lspconfig"

      local servers = {
        bashls = true,
        lua_ls = true,
        tsserver = true,
        pyright = true,
        vimls = true,
        marksman = true,
        dockerls = true,
        bufls = true,

        gopls = {
          cmd = { 'gopls', '--remote=auto' },
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
            },
          },

        },

        golangci_lint_ls = {
          cmd = { 'golangci-lint-langserver', '--nolintername' },
          init_options = {
            command = { "golangci-lint", "run", "--enable-all", "--disable",
              table.concat(disabled_go_linters, ","), "--out-format", "json" },
          },
        },

        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },

        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        },
      }

      local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == "table" then
          return not t.manual_install
        else
          return t
        end
      end, vim.tbl_keys(servers))

      require("mason").setup()

      require("mason-tool-installer").setup { ensure_installed = servers_to_install }

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
        }, config)

        lspconfig[name].setup(config)
      end

      local disable_semantic_tokens = {
        lua = true,
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
          vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, { buffer = 0 })

          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, { buffer = 0 })

          local filetype = vim.bo[bufnr].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end

          -- Highlight same ids
          if client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_augroup('lsp_document_highlight', {
              clear = false
            })
            vim.api.nvim_clear_autocmds({
              buffer = bufnr,
              group = 'lsp_document_highlight',
            })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              group = 'lsp_document_highlight',
              buffer = bufnr,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd('CursorMoved', {
              group = 'lsp_document_highlight',
              buffer = bufnr,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          severity_sort = true
        }
      )

      vim.diagnostic.config({
        virtual_text = {
          source = "if_many",
          prefix = '', -- Could be '●', '▎', 'x'
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
      local signs = { Error = "", Warn = "", Hint = "󰌶", Info = "" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  },
}
