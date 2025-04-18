--
--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
The goal is that you can read every line of code, top-to-bottom, understand
what your configuration is doing, and modify it to suit your needs.

Once you've done that, you should start exploring, configuring and tinkering to
explore Neovim!

If you don't know anything about Lua, I recommend taking some time to read through
a guide. One possible example:
- https://learnxinyminutes.com/docs/lua/


And then you can explore or search through `:help lua-guide`
- https://neovim.io/doc/user/lua-guide.html


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.

These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
local function getErrorCount()
  return '✗: ' .. #vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.ERROR } })
end
-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  'https://github.com/kevinhwang91/nvim-ufo.git',

  -- Auto pairs
  'https://github.com/cohama/lexima.vim',
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },

  -- html
  {
    'https://github.com/olrtg/nvim-emmet.git',
    config = function()
      vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
    end,
  },

  -- Use w, e and b to move through camelCase
  "bkad/CamelCaseMotion",

  -- undotree
  "mbbill/undotree",

  {
    'mg979/vim-visual-multi'
  },

  {
    'milisims/nvim-luaref'
  },

  {
    'folke/neodev.nvim',
    opts = {}
  },

  -- -- sass colorizer
  -- {
  --   'NvChad/nvim-colorizer.lua',
  --   config = function()
  --     require 'colorizer'.setup {
  --       user_default_options = {
  --         sass = { enable = true }
  --       }
  --     }
  --   end
  -- },
  --
  -- Rainbow brackets
  {
    'HiPhish/nvim-ts-rainbow2',
    dependencies = { 'nvim-treesitter' }
  },

  -- Fixes indentation for python
  {
    'Vimjas/vim-python-pep8-indent'
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = false,
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  -- navbuddy
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim",        -- Optional
      "nvim-telescope/telescope.nvim" -- Optional
    },
    config = function()
      require('nvim-navbuddy').setup({
        lsp = {
          auto_attach = true
        }
      })
    end
  },

  {
    "ibhagwan/fzf-lua",
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  {
    'dstein64/vim-startuptime'
  },

  -- smarter text wrapping
  {
    "andrewferrier/wrapping.nvim",
    opts = { auto_set_mode_heuristically = false },
    config = function()
      require("wrapping").setup()
    end
  },

  -- Session manager
  -- {
  --   "gennaro-tedesco/nvim-possession",
  --   dependencies = {
  --     "ibhagwan/fzf-lua",
  --   },
  --   config = function()
  --     require("nvim-possession").setup({
  --       autoload = true -- default false
  --     })
  --   end,
  --   init = function()
  --     local possession = require("nvim-possession")
  --     vim.keymap.set("n", "<leader>sl", function()
  --       possession.list()
  --     end)
  --     vim.keymap.set("n", "<leader>sn", function()
  --       possession.new()
  --     end)
  --     vim.keymap.set("n", "<leader>su", function()
  --       possession.update()
  --     end)
  --     vim.keymap.set("n", "<leader>sd", function()
  --       possession.delete()
  --     end)
  --   end,
  -- },

  -- Live Server for HTML
  {
    'barrett-ruth/live-server.nvim',
    build = 'npm add -g live-server',
    cmd = { 'LiveServerStart', 'LiveServerStop' },
    config = true
  },

  {
    "seblj/roslyn.nvim",
    ft = "cs",
    opts = {
      -- your configuration comes here; leave empty for default settings
    }
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- trouble.nvim
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000,    -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup({
        preset = "modern",
        options = {
          multilines = {
            enabled = true,
            always_show = true
          },
          add_messages = false
        }
      })
      vim.diagnostic.config({ virtual_text = false, signs = false })   -- Only if needed in your configuration, if you already have native LSP diagnostics
    end
  },

  -- {
  --   "folke/zen-mode.nvim",
  --   opts = {
  --     window = {
  --       backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
  --       -- height and width can be:
  --       -- * an absolute number of cells when > 1
  --       -- * a percentage of the width / height of the editor when <= 1
  --       -- * a function that returns the width or the height
  --       width = 120, -- width of the Zen window
  --       height = 1,  -- height of the Zen window
  --       -- by default, no options are changed for the Zen window
  --       -- uncomment any of the options below, or add other vim.wo options you want to apply
  --       options = {
  --         signcolumn = "no", -- disable signcolumn
  --         number = false,    -- disable number column
  --         -- relativenumber = false, -- disable relative numbers
  --         -- cursorline = false, -- disable cursorline
  --         -- cursorcolumn = false, -- disable cursor column
  --         -- foldcolumn = "0", -- disable fold column
  --         -- list = false, -- disable whitespace characters
  --       },
  --     },
  --     plugins = {
  --       -- disable some global vim options (vim.o...)
  --       -- comment the lines to not apply the options
  --       options = {
  --         enabled = true,
  --         ruler = true,   -- disables the ruler text in the cmd line area
  --         showcmd = true, -- disables the command in the last line of the screen
  --         -- you may turn on/off statusline in zen mode by setting 'laststatus'
  --         -- statusline will be shown only if 'laststatus' == 3
  --         laststatus = 0,              -- turn off the statusline in zen mode
  --       },
  --       twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
  --       gitsigns = { enabled = true }, -- disables git signs
  --       tmux = { enabled = false },    -- disables the tmux statusline
  --       todo = { enabled = true },     -- if set to "true", todo-comments.nvim highlights will be disabled
  --       -- this will change the font size on kitty when in zen mode
  --       -- to make this work, you need to set the following kitty options:
  --       -- - allow_remote_control socket-only
  --       -- - listen_on unix:/tmp/kitty
  --       kitty = {
  --         enabled = false,
  --         font = "+4", -- font size increment
  --       },
  --       -- this will change the font size on alacritty when in zen mode
  --       -- requires  Alacritty Version 0.10.0 or higher
  --       -- uses `alacritty msg` subcommand to change font size
  --       alacritty = {
  --         enabled = false,
  --         font = "14", -- font size
  --       },
  --       -- this will change the font size on wezterm when in zen mode
  --       -- See alse also the Plugins/Wezterm section in this projects README
  --       wezterm = {
  --         enabled = false,
  --         -- can be either an absolute font size or the number of incremental steps
  --         font = "+4", -- (10% increase per step)
  --       },
  --       -- this will change the scale factor in Neovide when in zen mode
  --       -- See alse also the Plugins/Wezterm section in this projects README
  --       neovide = {
  --         enabled = false,
  --         -- Will multiply the current scale factor by this number
  --         scale = 1.2,
  --         -- disable the Neovide animations while in Zen mode
  --         disable_animations = {
  --           neovide_animation_length = 0,
  --           neovide_cursor_animate_command_line = false,
  --           neovide_scroll_animation_length = 0,
  --           neovide_position_animation_length = 0,
  --           neovide_cursor_animation_length = 0,
  --           neovide_cursor_vfx_mode = "",
  --         }
  --       },
  --     },
  --     -- callback where you can add custom code when the Zen window opens
  --     on_open = function(win)
  --     end,
  --     -- callback where you can add custom code when the Zen window closes
  --     on_close = function()
  --     end,
  --   }
  -- },

  -- AI Coding assistants
  {
    'Exafunction/codeium.vim',
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.g.codeium_disable_bindings = 0
      vim.keymap.set('i', '<C-Enter>', function() return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<C-.>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<C-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<C-backspace>', function() return vim.fn['codeium#Clear']() end, { expr = true })
      vim.g.codeium_enabled = "v:false"
    end
  },

  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- add any options here
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     "rcarriga/nvim-notify",
  --     }
  -- },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      jsx_close_tag = {
        enable = true,
        filetypes = { "javascriptreact", "typescriptreact" },
      }
    },
  },

  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require 'alpha'.setup(require 'alpha.themes.startify'.config)
    end
  },

  {
    'yamatsum/nvim-cursorline',
    config = function()
      require('nvim-cursorline').setup {
        cursorline = {
          enable = true,
          timeout = 0,
          number = false,
        },
        cursorword = {
          enable = false,
          min_length = 3,
          hl = { underline = true },
        }
      }
    end
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  },

  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup()
    end
  },

  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup()
    end
  },

  -- nvim-tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        update_focused_file = {
          enable = true,
          -- update_cwd = true
        },
        view = {
          side = "right"
        },
        renderer = {
          indent_markers = {
            enable = true
          }
        }
      }
    end,
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = false },
      input = { enabled = false },
      picker = { enabled = false },
      notifier = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = true },
    },
  },

  -- Smooth scrolling
  -- {
  --   'declancm/cinnamon.nvim',
  --   config = function()
  --     local cinnamon = require('cinnamon').setup {
  --       keymaps = {
  --         basic = true,
  --         extra = true
  --       },
  --       options = {
  --         mode = 'cursor',
  --         delay = 5,
  --         max_delta = {
  --           time = 400,
  --         }
  --       }
  --     }
  --
  --     -- center screen on cursor
  --     vim.keymap.set("n", "G", function() require('cinnamon').scroll("Gzz") end)
  --   end
  -- },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    'hrsh7th/cmp-cmdline',
    event = 'VeryLazy',
    dependencies = {
      'hrsh7th/nvim-cmp',
    }
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',

    },
  },

  -- java
  {
    'nvim-java/nvim-java',
    config = function()
      require('java').setup()
      require('lspconfig').jdtls.setup({})
    end
  },

  -- cpp
  {
    'skywind3000/asyncrun.vim'
  },

  {
    'skywind3000/asynctasks.vim'
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',  opts = {} },
  event = 'VeryLazy',
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      signcolumn = false,
      numhl = true,
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    -- opts = {
    --   transparent = true
    -- },
    config = function()
      vim.cmd.colorscheme 'onedark'
      -- require('onedark').setup({
      -- })
      -- require('onedark').load()
    end,
  },

  {
    'xiyaowong/transparent.nvim'
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_x = { '%3{codeium#GetStatusString()}' },
        lualine_y = { getErrorCount, 'filetype' },
      }
    }
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Telescope plugin to get git repos
  {
    'cljoly/telescope-repo.nvim'
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {
  import = ''
}
)

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
vim.cmd([[
" Set js files to use jsx instead
augroup filetype_jsx
autocmd!
autocmd FileType javascript set filetype=javascriptreact
augroup END

" Auto-change directory to that of the currently opened file
autocmd BufEnter * silent! lcd %:p:h
]])

-- Put anything you want to happen only in Neovide here
if vim.g.neovide then
  vim.g.neovide_refresh_rate = 165
  vim.g.neovide_scroll_animation_length = 2
  require('cinnamon').setup {
    default_delay = 0
  }
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_particle_density = 17.0
  vim.o.guifont = "MonoLisa:style=Regular:scale=1" -- text below applies for VimScript

  -- Clipboard
  vim.cmd([[set clipboard=unnamed]])
  -- Neovide cliboard
  vim.keymap.set('v', '<M-c>', '"*y')         -- Copy
  vim.keymap.set('n', '<M-v>', '"*P')         -- Paste normal mode
  vim.keymap.set('v', '<M-v>', '"*P')         -- Paste visual mode
  vim.keymap.set('c', '<M-v>', '<C-R>*')      -- Paste command mode
  vim.keymap.set('i', '<M-v>', '<ESC>l"*Pli') -- Paste insert mode
end

-- auto text wrap for md files
local soft_wrap_pattern = '*.md'
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = { soft_wrap_pattern },
  callback = function()
    vim.cmd([[silent SoftWrapMode]])
    -- require("wrapping").soft_wrap_mode()
  end,
})

vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
  pattern = { soft_wrap_pattern },
  callback = function()
    vim.cmd([[ToggleWrapMode]])
    -- require("wrapping").toggle_wrap_mode()
  end,
})

-- Auto compile sass
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '[^_]*.sass,[^_]*.scss',
  callback = function()
    local filepath = string.gsub(vim.fn.expand('%:p'), " ", "\\ ")
    local command = string.format('!sass %s', filepath) .. " " .. vim.fn.expand('%:r.css') .. ".css"
    vim.cmd(command)
  end
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '[_]*.sass,[_]*.scss',
  callback = function()
    -- find files which end with .sass or .scss and do not start with _
    local matched_files = vim.fn.system("find *.scss")
    local files_table = vim.split(matched_files, '\n')
    for _, value in pairs(files_table) do
      if string.sub(value, 1, 1) ~= '_' and value ~= "" then
        local css_name = string.gsub(value, ".scss", "") .. ".css"
        vim.fn.system("sass " .. value .. " " .. css_name)
      end
    end
  end
})

-- setup windows for exercism project
vim.api.nvim_create_user_command('ExercismSetup',
  function(opts)
    -- close all but the last window
    local window_list = vim.api.nvim_list_wins()
    for i = 2, #window_list, 1 do
      vim.api.nvim_win_close(window_list[i], true)
    end

    -- delete all buffers
    local buffer_list = vim.api.nvim_list_bufs()
    for _, value in pairs(buffer_list) do
      vim.api.nvim_buf_delete(value, { force = true })
    end

    -- open exercism prjoect related files in buffers
    local files_in_current_dir = vim.fn.systemlist("ls")
    local file_regex = "%." .. opts.args .. "$"
    for _, value in pairs(files_in_current_dir) do
      if string.match(value, file_regex) then
        vim.api.nvim_command("edit " .. value)
      elseif string.match(value, "README.md") then
        vim.api.nvim_command("edit " .. value)
      end
    end
    vim.api.nvim_command("tab term")

    -- open 4 windows in splits
    buffer_list = vim.api.nvim_list_bufs()
    vim.cmd('split')
    vim.cmd('vsplit')
    vim.api.nvim_set_current_win(vim.api.nvim_list_wins()[3])
    vim.cmd('vsplit')

    -- open buffers in windows
    window_list = vim.api.nvim_list_wins()
    vim.api.nvim_win_set_buf(window_list[1], buffer_list[4])
    vim.api.nvim_win_set_buf(window_list[2], buffer_list[2])
    vim.api.nvim_win_set_buf(window_list[3], buffer_list[3])
    vim.api.nvim_win_set_buf(window_list[4], buffer_list[1])
    vim.api.nvim_set_current_win(vim.api.nvim_list_wins()[2])
  end,
  { nargs = 1 }
)

-- vim.api.nvim_create_user_command('ExercismSetup',
--   function()
--     local selected_window_number = vim.cmd('echo winnr()')
--     print(selected_window_number)
--
--     vim.cmd('vsplit')
--   end,
--   {}
-- )

-- Basic settings
vim.o.mouse = 'a'
vim.o.number = true
vim.o.splitright = true
vim.o.title = true
vim.o.wrap = false
vim.o.scrolloff = 5
vim.o.sidescrolloff = 10
vim.o.cursorline = true

vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.autoindent = true
vim.o.autoread = true


-- Make line numbers default
-- vim.wo.relativenumber = true
vim.o.number = true

-- highlight line numbers in visual mode


vim.go.wildmode = "list"

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Search and case
vim.o.hlsearch = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'auto'

-- Decrease update time
vim.o.updatetime = 200
vim.o.timeoutlen = 350

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]
vim.keymap.set('n', '<leader>n', ':Alpha<CR>')
vim.keymap.set({ 'n', 'v' }, '<F8>', '@:')
-- vim.cmd([[set clipboard+=unnamedplus]])
-- vim.keymap.set('v', '<leader>y', '"*y')         -- Copy
-- vim.keymap.set('n', '<leader>p', '"*P')         -- Paste normal mode
-- Neovide cliboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })


-- asynctasks
vim.g.asynctasks_term_rows = 40 -- set height for the horizontal terminal split
vim.g.asynctasks_term_cols = 80 -- set width for vertical terminal split
vim.cmd([[
let g:asyncrun_open = 6
]])
vim.keymap.set('n', '<F5>', ':AsyncTask file-build-and-run<CR>')
vim.keymap.set('n', '<F6>', ':AsyncTask file-run<CR>')
vim.keymap.set('n', '<F4>', ':AsyncTask')

-- Jump words
vim.keymap.set({'n', 'i'}, '<C-k>', function() Snacks.words.jump(-1, false) end)
vim.keymap.set({'n', 'i'}, '<C-j>', function() Snacks.words.jump(1, false) end)

-- camelCaseMotion
vim.cmd([[
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge
" omap <silent> iw <Plug>CamelCaseMotion_iw
" xmap <silent> iw <Plug>CamelCaseMotion_iw
" omap <silent> ib <Plug>CamelCaseMotion_ib
" xmap <silent> ib <Plug>CamelCaseMotion_ib
" omap <silent> ie <Plug>CamelCaseMotion_ie
" xmap <silent> ie <Plug>CamelCaseMotion_ie
]])


-- File shortcuts
vim.keymap.set('n', '<leader>oe', ':e /home/todd/Documents/Projects/exercism-exercises/<CR>')
vim.keymap.set('n', '<leader>op', ':e /home/todd/Documents/Projects/<CR>')

-- undotree
vim.keymap.set({ 'v', 'n' }, '<leader>u', ':UndotreeToggle<CR>')

-- Exit terminal mode
vim.keymap.set({ 't', 'n' }, '<Esc>', '<C-\\><C-n>')

-- Telescope + LSP
vim.keymap.set('n', '<leader>ld', ':Telescope lsp_definitions<CR>', { desc = 'Go to definition' })
vim.keymap.set('n', '<leader>lu', ':Telescope lsp_references<CR>', { desc = 'Go to reference' })
vim.keymap.set('n', '<leader>lr', function() vim.lsp.buf.rename() end, { desc = 'Rename symbol' })
vim.keymap.set('n', '<leader>ls', ':Telescope lsp_document_symbols<CR>', { desc = 'View document symbols' })
vim.keymap.set('n', '<leader>li', ':Telescope lsp_implementations<CR>', { desc = 'Go to implementation' })
vim.keymap.set({ 'n', 'i' }, 'K', function() vim.lsp.buf.hover() end)
vim.keymap.set({ 'n', 'i' }, '<C-f>', function() vim.lsp.buf.format() end)

-- Telescope open git repos
vim.keymap.set('n', '<leader>fr', ':Telescope repo cached_list<CR>', { desc = 'Open list of git repos' })
vim.keymap.set('n', '<leader>fR', ':Telescope repo list<CR>', { desc = 'Open list of git repos with recursive search' })

-- Telescope find files
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', ':Telescope git_files<CR>', { desc = 'Find git files' })

-- Bufferline/buffer mappings
vim.keymap.set({ 'n', 'v' }, '<C-l>', ':bnext<CR>')
vim.keymap.set({ 'n', 'v' }, '<C-h>', ':bprev<CR>')
vim.keymap.set({ 'n', 'v' }, '<C-x>', ':bd<CR>')

-- Open file with default application
vim.keymap.set({ 'n', 'v' }, '<F3>', ':silent update<Bar>silent !xdg-open %:p &<CR>')

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- telescope-file-browser mappings
vim.keymap.set({ "n", "v" }, "<leader>fb", ":Telescope file_browser<CR>")

vim.keymap.set({ 'n', 'v' }, '<leader>T', ':NvimTreeFindFileToggle<CR>')

-- nvim-tree mappings
vim.keymap.set({ 'n', 'v' }, '<leader>t', ':NvimTreeFocus<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>T', ':NvimTreeFindFileToggle<CR>')

-- navbuddy
vim.keymap.set({ 'n', 'v' }, '<leader>n', ':Navbuddy<CR>')

-- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- require("noice").setup({
--   lsp = {
--     -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
--     override = {
--       ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--       ["vim.lsp.util.stylize_markdown"] = true,
--       ["cmp.entry.get_documentation"] = true,
--     },
--   },
--   -- you can enable a preset for easier configuration
--   presets = {
--     bottom_search = true, -- use a classic bottom cmdline for search
--     command_palette = true, -- position the cmdline and popupmenu together
--     long_message_to_split = true, -- long messages will be sent to a split
--     inc_rename = false, -- enables an input dialog for inc-rename.nvim
--     lsp_doc_border = true, -- add a border to hover docs and signature help
--   },
-- })

-- toggle between relativenumber and norelativenumuber
local toggle_relativenumber = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local return_command = ':' .. bufnr .. 'b'
  vim.cmd 'bufdo set rnu!'
  vim.cmd(return_command)
end
vim.keymap.set('n', '<leader>rl', function() toggle_relativenumber() end,
  { desc = 'Toggle relativenumber for all buffers' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  extensions = {
    file_browser = {
      hidden = { file_browser = true, folder_browser = true }
    }
  },
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enter normal mode after using telescope prompt
vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    end
  end,
})

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep({
      search_dirs = { git_root },
    })
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

--
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    rainbow = {
      enable = false,
      -- disable = { 'jsx', 'cpp' }, -- list of languages you want to disable the plugin for
      query = 'rainbow-parens',                         -- Which query to use for finding delimiters
      strategy = require('ts-rainbow').strategy.global, -- Highlight the entire buffer all at once
    },

    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'java' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  vim.keymap.set({ 'n', 'v' }, '<leader>F', function() vim.lsp.buf.format() end,
    { buffer = bufnr, desc = 'Format current buffer with LSP' })
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  -- nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
  for k, v in pairs(vim.lsp.get_active_clients()) do
    if v.name == 'tsserver' then
      vim.lsp.stop_client(v.id)
    end
  end
end

-- outdated method
-- -- document existing key chains
-- require('which-key').register {
--   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
--   ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
--   ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
--   ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
--   ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
--   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
--   ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
-- }

-- New method
-- document existing key chains
require('which-key').add {
  { '<leader>c', name = '[C]ode' },
  { '<leader>d', name = '[D]ocument' },
  { '<leader>g', name = '[G]it' },
  { '<leader>h', group = 'Git [H]unk',     mode = { 'n', 'v' } },
  { '<leader>r', name = '[R]ename' },
  { '<leader>s', name = '[S]earch' },
  { '<leader>t', name = '[T]oggle' },
  { '<leader>w', name = '[W]orkspace' },

  -- register which-key VISUAL mode
  -- required for visual <leader>hs (hunk stage) to work
  { '<leader>',  name = 'VISUAL <leader>', mode = { 'v' } },
}

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  tailwindcss = { filetypes = { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' } },
  ts_ls = { filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact' } },
  eslint = { filetypes = { '' } },
  html = { filetypes = { 'html', 'twig', 'hbs' } },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

-- console.log({$1})
luasnip.add_snippets("typescriptreact", {
  luasnip.snippet("cl", {
    luasnip.text_node("console.log("),
    luasnip.insert_node(1),
    luasnip.text_node(")"),
  })
})

luasnip.add_snippets("typescript", {
  luasnip.snippet("cl", {
    luasnip.text_node("console.log("),
    luasnip.insert_node(1),
    luasnip.text_node(")"),
  })
})

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    -- ['<CR>'] = cmp.mapping.confirm {
    --   behavior = cmp.ConfirmBehavior.Replace,
    --   select = true,
    -- },

    -- ['<C-j>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     for i = 1, 3, 1 do
    --       cmp.select_next_item()
    --     end
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
    -- ['<C-k>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     for i = 1, 3, 1 do
    --       cmp.select_prev_item()
    --     end
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      -- cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    }
  }
};

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})

-- Emmet leader key
-- vim.cmd([[
-- unmap <C-y>
-- imap   <C-y>,   <plug>(emmet-expand-abbr)
-- imap   <C-y>;   <plug>(emmet-expand-word)
-- imap   <C-y>u   <plug>(emmet-update-tag)
-- imap   <C-y>d   <plug>(emmet-balance-tag-inward)
-- imap   <C-y>D   <plug>(emmet-balance-tag-outward)
-- imap   <C-y>n   <plug>(emmet-move-next)
-- imap   <C-y>N   <plug>(emmet-move-prev)
-- imap   <C-y>i   <plug>(emmet-image-size)
-- imap   <C-y>/   <plug>(emmet-toggle-comment)
-- imap   <C-y>j   <plug>(emmet-split-join-tag)
-- imap   <C-y>k   <plug>(emmet-remove-tag)
-- imap   <C-y>a   <plug>(emmet-anchorize-url)
-- imap   <C-y>A   <plug>(emmet-anchorize-summary)
-- imap   <C-y>m   <plug>(emmet-merge-lines)
-- imap   <C-y>c   <plug>(emmet-code-pretty)
-- ]])
-- vim.g.user_emmet_leader_key = '<C-y>'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
