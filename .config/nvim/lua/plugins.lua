return {
  ---------------------------------------------------
  -- 他プラグインから利用される汎用プラグイン -------
  ---------------------------------------------------
  {
    'lewis6991/impatient.nvim',
    config = function ()
      require('impatient')
    end
  },
  { 'MunifTanjim/nui.nvim' },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'vim-denops/denops.vim' },

  ---------------------------------------------------
  -- ファイラー -------------------------------------
  ---------------------------------------------------
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'plenary.nvim',
      'nvim-web-devicons',
      'nui.nvim'
    },
    config = function() 
      require('neo-tree').setup({
        popup_border_style = 'NC',
        window = {
          position = 'float',
        },
        filesystem = {
          window = {
            mappings = {
              ['h'] = 'toggle_hidden',
            }
          }
        },
        default_component_configs = {
          git_status = {
             symbols = {
               -- 以下のシンボルはデフォルトを上書き
               added     = '✚',
               modified  = '➤',
            }
          },
        }
      })
    end
  },

  ---------------------------------------------------
  -- ファジーファインダー ---------------------------
  ---------------------------------------------------
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() 
      local telescope = require('telescope')

      telescope.setup{
        -- 設定が必要になったらここへ
        defaults = {
          sorting_strategy = 'ascending',
          layout_config = {
            prompt_position = 'top',
          },
          file_ignore_patterns = {
            '.git/',
            'target/',
            '.metals/',
            '.bloop/'
          },
        }
      }
    end,
    init = function()
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<Space><Space>', builtin.find_files, {})
      vim.keymap.set( 'n', '<Space>h',
        function()
          builtin.find_files({
            hidden = true
          })
        end,
        {}
      )
      vim.keymap.set('n', '<Space>b',
        function()
          builtin.buffers({
            ignore_current_buffer = true,
            sort_lastused = true,
          })
        end,
        {}
      )
      vim.keymap.set('n', '<Space>gr', builtin.live_grep, {})
      vim.keymap.set('n', '<Space>gs', builtin.git_status, {})
      vim.keymap.set('n', '<Space>gw', builtin.lsp_document_symbols, {})
      vim.keymap.set('n', '<Space>in',
        function()
          builtin.lsp_code_actions({})
        end,
        {}
      )

      -- with noice.nvim
      vim.keymap.set('n', '<Space>no',
        function()
          vim.cmd('Noice telescope')
        end,
        {}
      )
    end
  },

  ---------------------------------------------------
  -- 装飾 -------------------------------------------
  ---------------------------------------------------
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'material',
          disabled_filetypes = {},
          always_divide_middle = true,
          colored = false,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff'},
          lualine_c = {
            {
              'filename',
              path = 1,
              file_status = true,
              shorting_target = 40,
              symbols = {
                modified = ' [+]',
                readonly = ' [RO]',
                unnamed = 'Untitled',
              }
            },
            'progress'
          },
          lualine_x = {'filetype', 'encoding'},
          lualine_y = {
            {
              'diagnostics',
              source = {'nvim-lsp'},
              sections = { 'error', 'warn', 'info', 'hint' },
    
              diagnostics_color = {
                error = 'DiagnosticError',
                warn  = 'DiagnosticWarn',
                info  = 'DiagnosticInfo',
                hint  = 'DiagnosticHint',
              },
              symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
              colored = true,
              update_in_insert = false,
              always_visible = false,
            }
          },
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {
          lualine_a = {'buffers'},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        extensions = {}
      }
    end
  },

  ---------------------------------------------------
  -- Color Settings ---------------------------------
  ---------------------------------------------------
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VimEnter',
    build = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {
          'bash',
          'css',
          'dockerfile',
          'hocon',
          'html',
          'json',
          'lua',
          'php',
          'rust',
          'scala',
          'sql',
          'toml',
          'vim'
        },
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = function(lang, bufnr)
            local filename = vim.api.nvim_buf_get_name(0)
            local is_dein = string.find(filename, '.dein.toml')
            local is_dein_lazy = string.find(filename, '.dein_lazy.toml')

            -- .dein.toml または .dein_lazy.toml では vim-precious を使いたいので、treesitter を有効にしない
            return is_dein ~= nil or is_dein_lazy ~= nil
          end,
        },
--        -- p00f/nvim-ts-rainbow
--        rainbow = {
--          enable = true,
--          extended_mode = true,
--          max_file_lines = 300,
--        },
--        -- andymass/vim-matchup
--        matchup = {
--          enable = true,
--        },
      }
    end,
  },
  {
    'catppuccin/nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-treesitter' },
    build = ':CatppuccinCompile',
    config = function()
      require('catppuccin').setup({
        transparent_background = true,
        term_colors = false,
        styles = {
          comments = { 'italic', 'bold' },
          functions = { 'bold' },
          types = { 'bold' },
          keywords = {' bold' },
          strings = { 'bold' },
          numbers = { 'bold' },
          booleans = { 'bold' },
          conditionals = {},
          loops = {},
          properties = {},
          variables = {},
          operators = {},
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          treesitter = true,
          ts_rainbow = true,
          neotree = true,
          lsp_trouble = true,
        },
      })
    end,
    -- 以下はプラグイン設定とは関係ないが、色関連の設定なので一箇所にまとめておく
    init = function()
      -- 行番号
      vim.api.nvim_set_hl(0, 'LineNr', { ctermfg=7, ctermbg=none })

      -- FloatWindow用にNormalFloatグループを設定
      vim.api.nvim_set_hl(0, 'NormalFloat', { ctermbg=240 })

      -- yank 対象の色を変更するためのグループを設定
      vim.api.nvim_set_hl(0, 'HighlightedyankRegion', { fg='#2a2a2a', bg='#ffec80' })
      local myYankHighlight = vim.api.nvim_create_augroup('MyYankHighlight', { clear = true })
      vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
        pattern = '*',
        group = myYankHighlight,
        callback = function()
          vim.highlight.on_yank{ higroup='HighlightedyankRegion', timeout=700 }
        end,
      })
    end,
  },

  ---------------------------------------------------
  -- 便利ツール ---------------------------------
  ---------------------------------------------------
  {
    'Shougo/deol.nvim',
    init = function()
      -- 【Ctrl + o】 float windowでターミナルを表示
      vim.keymap.set('n', '<C-o>', '<cmd>Deol -split=floating -winheight=30 -winwidth=100<CR>', { noremap = true, silent = true })
    end
  },
  {
    'reireias/vim-cheatsheet',
    init = function()
      vim.g['cheatsheet#cheat_file'] = '~/dotfiles/cheatsheet.md'

      vim.g['cheatsheet#float_window'] = 1

      vim.g['cheatsheet#float_window_width_ratio'] = 0.6
      vim.g['cheatsheet#float_window_height_ratio'] = 1.0

      -- チートシートの編集
      vim.cmd('command! EditCheat :edit ~/dotfiles/cheatsheet.md')

      vim.keymap.set('n', '<Space>?', '<cmd>Cheat<CR>', { noremap = true })
      vim.keymap.set('n', '<Space>E', '<cmd>EditCheat<CR>', { noremap = true })
    end
  },

  ---------------------------------------------------
  -- LSP --------------------------------------------
  ---------------------------------------------------
  {
    'neovim/nvim-lspconfig',
    init = function()
      local opts = { noremap=true, silent=true }

      vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
      vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
      vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      ------------------------------------------------
      -- Rust
      ------------------------------------------------
      require'lspconfig'.rust_analyzer.setup{
        on_attach = on_attach,
        settings = {
          -- ref: https://rust-analyzer.github.io/manual.html#configuration
          ["rust-analyzer"] = {
            imports = {
              granularity = {
                group = "module",
              },
              prefix = "self",
            },
            cargo = {
              buildScripts = {
                enable = true,
              },
            },
            procMacro = {
              enable = true
            },
          }
        },
        handlers = {
          ["textDocument/definition"] = function(_, result, params)
            -- エラーは Maan2003/lsp_lines.nvim にお任せするの表示しないようにする
            return nil
          end
        }
      }

      ------------------------------------------------
      -- Deno
      ------------------------------------------------
      require'lspconfig'.denols.setup{
        on_attach = on_attach
      }
    end
  },
  {
    'williamboman/mason.nvim',
    config = function()
      local mason = require('mason')

      mason.setup({
        install_root_dir = os.getenv("HOME").."/.lsp/data"  ,
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require("mason-lspconfig").setup({
          ensure_installed = {
            "dockerls",
            "html",
            "jsonls",
            "intelephense",
            "vimls",
          }
      })
    end,
    init = function()
      local mason_lspconfig = require('mason-lspconfig')

      mason_lspconfig.setup_handlers({
        function(server_name)
          local opts = {}
          opts.on_attach = function(_, bufnr)
            local bufopts = { silent = true, buffer = bufnr }
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
          end

          local nvim_lsp = require('lspconfig')
          nvim_lsp[server_name].setup(opts)
        end
      })
    end
  },
}
