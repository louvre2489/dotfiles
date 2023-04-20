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
      require("neo-tree").setup({
        popup_border_style = "NC",
        window = {
          position = "float",
        },
        filesystem = {
          window = {
            mappings = {
              ["h"] = "toggle_hidden",
            }
          }
        },
        default_component_configs = {
          git_status = {
             symbols = {
               -- 以下のシンボルはデフォルトを上書き
               added     = "✚",
               modified  = "➤",
            }
          },
        }
      })
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
    build = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "bash",
          "css",
          "dockerfile",
          "hocon",
          "html",
          "json",
          "lua",
          "php",
          "rust",
          "scala",
          "sql",
          "toml",
          "vim"
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
            local is_dein = string.find(filename, ".dein.toml")
            local is_dein_lazy = string.find(filename, ".dein_lazy.toml")

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
    end
  },
  {
    'catppuccin/nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-treesitter' },
    build = ":CatppuccinCompile",
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        term_colors = false,
        styles = {
          comments = { "italic", "bold" },
          functions = { "bold" },
          types = { "bold" },
          keywords = {" bold" },
          strings = { "bold" },
          numbers = { "bold" },
          booleans = { "bold" },
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
    end
  },
  ---------------------------------------------------
  -- 便利ツール ---------------------------------
  ---------------------------------------------------
}
