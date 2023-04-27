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
    event = 'VeryLazy',
    lazy = true,
    dependencies = {
      'plenary.nvim',
      'nvim-web-devicons',
      'nui.nvim'
    },
    init = function()
      -- ファイラーの起動方法
      vim.keymap.set('n', '<C-e>','<cmd>NeoTreeFloatToggle<CR>', { noremap = true, silent = true })
    end,
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
          },
          filtered_items = {
            visible = true,
            hide_by_name = {
              '.DS_Store',
              'node_modules'
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
  -- Git --------------------------------------------
  ---------------------------------------------------
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    lazy = true,
    init = function()
      -- ハイライトの設定
      vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg='#00ff00' })
      vim.api.nvim_set_hl(0, 'GitSignsAddNr', { fg='#00ff00' })
      vim.api.nvim_set_hl(0, 'GitSignsAddLn', { fg='#00ff00' })
      vim.api.nvim_set_hl(0, 'GitSignsChange', { fg='#6495ed' })
      vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { fg='#6495ed' })
      vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { fg='#6495ed' })

      -- 変更箇所をハイライトするかどうかを切り替える
      vim.cmd('command! GWD :Gitsigns toggle_word_diff')
    end,
    config = function()
      require('gitsigns').setup{
        signs = {
          change = {
            hl = 'GitSignsChange',
            text = '*',
            numhl='GitSignsChangeNr',
            linehl='GitSignsChangeLn'
          },
        },
        -- ハイライト設定
        signcolumn = true,
        numhl      = true,
        word_diff  = false,
        -- APZelos/blamer.nvim の方が便利
        current_line_blame = false,
      }
    end
  },
  {
    'rhysd/committia.vim',
  },
  {
    'APZelos/blamer.nvim',
    event = 'VimEnter',
    lazy = true,
    init = function()
      vim.g.blamer_enabled = 1
      vim.g.blamer_delay = 500
      vim.g.blamer_date_format = '%Y/%m/%d'
      vim.g.blamer_prefix = '     [blame]  '
      vim.g.blamer_template = '<commit-short>, <committer>, <committer-time>, <summary>'
    end
  },

  ---------------------------------------------------
  -- いいかんじの見た目にする -----------------------
  ---------------------------------------------------
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    lazy = true,
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
  {
    'folke/noice.nvim',
    event = 'VimEnter',
    lazy = true,
    config = function()
      require('noice').setup {
        popupmenu = {
          enabled = false,
        },
       hacks = {
          -- これがないと、ntpeters/vim-better-whitespace のせいで固まることがある
          skip_duplicate_messages = true,
        },
      }
    end
  },
  {
    'rcarriga/nvim-notify',
    event = 'VimEnter',
    lazy = true,
    config = function()
      require('notify').setup {
        stages = 'static',
      }
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufEnter',
    lazy = true,
    init = function()
      vim.api.nvim_set_hl(0, 'IndentBlanklineIndent1', { fg='#E5C07B', nocombine=true })
      vim.api.nvim_set_hl(0, 'IndentBlanklineIndent2', { fg='#98C379', nocombine=true })
      vim.api.nvim_set_hl(0, 'IndentBlanklineIndent3', { fg='#56B6C2', nocombine=true })
      vim.api.nvim_set_hl(0, 'IndentBlanklineIndent4', { fg='#E06C75', nocombine=true })
      vim.api.nvim_set_hl(0, 'IndentBlanklineIndent5', { fg='#61AFEF', nocombine=true })
      vim.api.nvim_set_hl(0, 'IndentBlanklineIndent6', { fg='#C678DD', nocombine=true })
    end,
    config = function()
      require('indent_blankline').setup {
        char_highlight_list = {
          'IndentBlanklineIndent1',
          'IndentBlanklineIndent2',
          'IndentBlanklineIndent3',
          'IndentBlanklineIndent4',
          'IndentBlanklineIndent5',
          'IndentBlanklineIndent6',
        },
      }
    end
  },

  ---------------------------------------------------
  -- Color Settings ---------------------------------
  ---------------------------------------------------
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VimEnter',
    lazy = true,
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
          disable = function(_, _)
            local filename = vim.api.nvim_buf_get_name(0)
            local is_dein = string.find(filename, '.dein.toml')
            local is_dein_lazy = string.find(filename, '.dein_lazy.toml')

            -- .dein.toml または .dein_lazy.toml では vim-precious を使いたいので、treesitter を有効にしない
            return is_dein ~= nil or is_dein_lazy ~= nil
          end,
        },
        -- HiPhish/nvim-ts-rainbow2
        rainbow = {
          enable = true,
        },
        -- andymass/vim-matchup
        matchup = {
          enable = true,
        },
      }
    end,
  },
  {
    'HiPhish/nvim-ts-rainbow2',
    event = 'VimEnter',
    lazy = true,
    dependencies = {
      'nvim-treesitter'
    }
  },
  {
    'andymass/vim-matchup',
    event = 'VimEnter',
    lazy = true,
    dependencies = {
      'nvim-treesitter'
    }
  },
  {
    'catppuccin/nvim',
    event = 'VimEnter',
    lazy = true,
    dependencies = { 'nvim-treesitter' },
    build = ':CatppuccinCompile',
    init = function()
      vim.g.catppuccin_flavour = 'frappe'
      vim.api.nvim_command 'colorscheme catppuccin'
    end,
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

      -- 以下はプラグイン設定とは関係ないが、色関連の設定なので一箇所にまとめておく

      -- 行番号
      vim.api.nvim_set_hl(0, 'LineNr', { ctermfg=7 })

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
    end
  },
  {
    'norcalli/nvim-colorizer.lua',
    event = 'BufEnter',
    lazy = true,
    init = function()
      vim.cmd('command! CA lua require("colorizer").attach_to_buffer(0)')
    end,
    config = function()
      require 'colorizer'.setup{
      }
    end
  },

  ---------------------------------------------------
  -- 便利ツール -------------------------------------
  ---------------------------------------------------
 {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
    lazy = true,
    init = function()
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<Space><Space>', builtin.find_files, {})
      vim.keymap.set('n', '<Space>h',
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
    end,
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
    end
  },
  {
    'Shougo/deol.nvim',
    event = 'VeryLazy',
    lazy = true,
    init = function()
      -- 【Ctrl + o】 float windowでターミナルを表示
      vim.keymap.set('n', '<C-o>', '<cmd>Deol -split=floating -winheight=30 -winwidth=100<CR>', { noremap = true, silent = true })

      -- 【ESC】 ターミナルモードから抜ける
      vim.keymap.set('t', '<ESC>', '<C-\\><C-n>', { noremap = true, silent = true })
    end
  },
  {
    'reireias/vim-cheatsheet',
    event = 'VeryLazy',
    lazy = true,
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
  {
    'Shougo/context_filetype.vim',
    event = 'BufEnter',
    lazy = true
  },
  {
    'osyo-manga/vim-precious',
    event = 'BufEnter',
    lazy = true,
    dependencies = {
      'context_filetype.vim'
    }
  },
  {
    'ntpeters/vim-better-whitespace',
    event = 'VeryLazy',
    lazy = true,
    init = function()
      -- 保存時に末尾の空白を自動的に削除する
      vim.g.better_whitespace_enabled = 1
      vim.g.strip_whitespace_confirm = 0
      vim.g.strip_only_modified_lines = 1

      vim.cmd('autocmd BufWritePre * :StripWhitespace')
    end
  },

  ---------------------------------------------------
  -- LSP関連 ----------------------------------------
  ---------------------------------------------------
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    lazy = true,
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'folke/neodev.nvim' },
    },
    config = function()
      local mason = require('mason')
      local mason_lspconfig = require('mason-lspconfig')

      mason.setup({
        install_root_dir = os.getenv('HOME')..'/.lsp/data'  ,
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗'
          }
        }
      })

      mason_lspconfig.setup({
        ensure_installed = {
          'lua_ls',
          'denols',
          'dockerls',
          'html',
          'jsonls',
          'intelephense',
          'vimls',
          'rust_analyzer'
        },
      })

      mason_lspconfig.setup_handlers({
        function(server_name)

          local opts = {}
          opts.on_attach = function(_, bufnr)
            local bufopts = { silent = true, buffer = bufnr }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
          end

          local nvim_lsp = require('lspconfig')
          nvim_lsp[server_name].setup(opts)
        end
      })

      ------------------------------------------------
      -- Rust
      ------------------------------------------------
      require'lspconfig'.rust_analyzer.setup{
        settings = {
          -- ref: https://rust-analyzer.github.io/manual.html#configuration
          ['rust-analyzer'] = {
            imports = {
              granularity = {
                group = 'module',
              },
              prefix = 'self',
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
          ['textDocument/definition'] = function(_, _, _)
            -- エラーは Maan2003/lsp_lines.nvim にお任せするの表示しないようにする
            return nil
          end
        }
      }

      ------------------------------------------------
      -- Lua
      ------------------------------------------------
      require('neodev').setup{}
      require'lspconfig'.lua_ls.setup {
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {'vim'},
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file('', true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
            completion = {
              callSnippet = "Replace"
            }
          },
        }
      }

      ------------------------------------------------
      -- Deno
      ------------------------------------------------
      require'lspconfig'.denols.setup{
      }
    end
  },
  {
    'j-hui/fidget.nvim',
    event = 'BufEnter',
    lazy = true,
    config = function()
      require'fidget'.setup{}
    end
  },
  {
    'folke/trouble.nvim',
    dependencies = {
     'nvim-web-devicons'
    },
    event = 'BufEnter',
    lazy = true,
    init = function()
      vim.keymap.set('n', '<S-t><S-t>','<cmd> TroubleToggle workspace_diagnostics<CR>', { noremap = true })
      vim.keymap.set('n', '<S-t><S-d>','<cmd> TroubleToggle document_diagnostics<CR>', { noremap = true })

      vim.cmd('command! TC TroubleClose')
    end,
    config = function()
      require('trouble').setup {}
    end
  },

  ---------------------------------------------------
  -- 補完 -------------------------------------------
  ---------------------------------------------------
  {
    'Shougo/ddc.vim',
    event = 'InsertEnter',
    lazy = true,
    dependencies = {
      'vim-denops/denops.vim',
      'Shougo/ddc-ui-native',
      'LumaKernel/ddc-file',
      'Shougo/ddc-source-around',
      'Shougo/ddc-matcher_head',
      'Shougo/ddc-sorter_rank',
      'Shougo/ddc-converter_remove_overlap',
      'Shougo/ddc-source-nvim-lsp',
      'matsui54/denops-popup-preview.vim',
      'matsui54/denops-signature_help',
    },
    keys = {
      {
        -- 補完
        '<TAB>',
        function()
          if vim.fn.pumvisible() > 0 then
            return '<C-n>'
          else
            local line = vim.api.nvim_get_current_line()
            local col = vim.fn.col('.')
            if col <= 1 or line:sub(col - 2):match('%s') then
              return '<TAB>'
            else
              return vim.api.nvim_call_function('ddc#map#manual_complete', {})
            end
          end
        end,
        mode = 'i',
        expr = true,
        silent = true,
      },
      {
        -- 補完候補を戻る
        '<S-TAB>',
        function()
          return vim.fn.pumvisible() > 0 and '<C-p>' or '<C-n>'
        end,
        mode = 'i',
        expr = true,
        silent = true,
      },
      {
        --  C-n/C-pで補完候補を選択した時は<C-y>で選択確定しないとauto-importが実行されない
        '<CR>',
        function()
          return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
        end,
        mode = 'i',
        expr = true,
        silent = true,
      }
    },
    config = function()
      -- 補完選択時にプレビューウインドウが表示されないようにする
      vim.opt.completeopt:remove('preview')

      vim.fn['ddc#custom#patch_global']({
        ui = 'native',
        sources = {'file', 'nvim-lsp', 'around'},
        sourceOptions = {
          _ = {
            matchers = {'matcher_head'},
            sorters = {'sorter_rank'},
            converters =  {'converter_remove_overlap'},
            minAutoCompleteLength = 1,
          },
          around = {
            mark = 'A',
          },
          file = {
            mark = 'F',
            isVolatile = true,
            forceCompletionPattern = '\\S/\\S*',
          },
          ['nvim-lsp'] = {
            mark = 'LSP',
            dup = true,
            forceCompletionPattern = '\\.\\w*|:\\w*|->\\w*',
          },
        },
        sourceParams = {
          around = {
            maxSize = 30
          },
          ['nvim-lsp'] = {
            maxSize = 500
          },
        },
        filterParams = {
          matcher_fuzzy = {
            splitMode = 'character'
          },
          converter_fuzzy = {
            hlGroup = 'SpellBad'
          }
        }
      })

      vim.api.nvim_call_function('ddc#enable', {})
    end
  },
  {
    'matsui54/denops-popup-preview.vim',
    event = 'User DenopsReady',
    lazy = true,
    dependencies = {
      'denops.vim',
    },
    config = function()
      vim.api.nvim_call_function('popup_preview#enable', {})
    end
  },
  {
    'matsui54/denops-signature_help',
    event = 'User DenopsReady',
    lazy = true,
    dependencies = {
      'denops.vim',
    },
    config = function()
      vim.g.signature_help_config = {
        contentsStyle = 'currentLabel',
        viewStyle = 'virtual',
      }
      vim.api.nvim_call_function('signature_help#enable', {})
    end
  }
}
