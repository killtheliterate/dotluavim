-- LSP Configuration & Plugins

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      { 'folke/neodev.nvim', opts = {} },
      'yioneko/nvim-vtsls',
    },
    config = function()
      vim.lsp.set_log_level 'debug'

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('killtheliterate-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
          map('gD', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinitions')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          -- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client.name == 'vtsls' then
            vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, { buffer = event.buf, desc = 'vtsls: [C]ode [L]ens' })
            vim.keymap.set('n', 'gs', require('vtsls').commands.goto_source_definition, { buffer = event.buf, desc = 'vtsls: [G]oto [S]ources' })

            vim.lsp.commands['editor.action.showReferences'] = function(command, ctx)
              local locations = command.arguments[3]

              if locations and #locations > 0 then
                local items = vim.lsp.util.locations_to_items(locations, client.offset_encoding)
                vim.fn.setloclist(0, {}, ' ', { title = 'References', items = items, context = ctx })
                vim.api.nvim_command 'lopen'
              end
            end
          end

          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('killtheliterate-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('killtheliterate-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'killtheliterate-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        bashls = {},
        denols = {},
        elixirls = {},
        -- @TODO: eslint-lsp is sloooooooow
        -- eslint = {},
        html = {},
        jsonls = {},
        pyright = {},
        rust_analyzer = {},
        svelte = {},
        vtsls = {
          settings = {
            typescript = {
              inlayHints = {
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
          },
        },

        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'codespell',
        'eslint_d',
        'prettierd',
        'stylua',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      local lspconfig = require 'lspconfig'
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}

            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

            lspconfig[server_name].setup(server)
          end,

          ['denols'] = function()
            lspconfig.denols.setup {
              root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),

              init_options = {
                lint = true,
                unstable = false,
              },
            }
          end,

          ['vtsls'] = function()
            local original_handler = vim.lsp.handlers['textDocument/definition']

            local first_definition_handler = function(err, result, ctx, config)
              if result and vim.islist(result) and #result > 1 then
                original_handler(err, { result[1] }, ctx, config)
              else
                original_handler(err, result, ctx, config)
              end
            end

            lspconfig.vtsls.setup {
              root_dir = lspconfig.util.root_pattern 'package.json',

              single_file_support = false,

              init_options = {
                vtsls = {
                  addMissingImports = true,
                },
              },

              -- @TODO: overrides do not work
              -- @see: https://www.reddit.com/r/neovim/comments/15vxpss/specific_configuration_for_a_language_server
              -- @see: https://www.reddit.com/r/neovim/comments/1agwrqa/how_to_extend_masons_automatic_server
              -- @see: https://www.reddit.com/r/neovim/comments/1co6g92/how_to_connect_csharpls_extended_in_lazy
              -- @see: https://www.reddit.com/r/neovim/comments/1b75th3/comment/ktgns2i
              -- @see: https://github.com/typescript-language-server/typescript-language-server/issues/216
              handlers = {
                ['textDocument/definition'] = first_definition_handler,
              },
            }
          end,

          -- ['eslint'] = function()
          --   lspconfig.eslint.setup {
          --     root_dir = lspconfig.util.root_pattern('.eslintrc', '.eslintrc.js', '.eslintrc.json'),
          --
          --     settings = {
          --       format = false,
          --     },
          --
          --     handlers = {
          --       ['window/showMessageRequest'] = function(_, result)
          --         return result.message:match 'ENOENT' and vim.NIL or result
          --       end,
          --     },
          --   }
          -- end,
        },
      }
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
