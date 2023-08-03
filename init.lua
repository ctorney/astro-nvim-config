vim.g.everforest_transparent_background = 2
vim.g.everforest_background = "hard"
vim.g.copilot_assume_mapped = true

local functions = require('user.functions')
return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  colorscheme = "everforest",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
    },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
           "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },

   -- Disable default plugins
  enabled = {
    cmp = false,
    bufferline = false,
    neo_tree = true,
    lualine = false,
    gitsigns = true,
    colorizer = true,
    toggle_term = true,
    comment = true,
    symbols_outline = true,
    indent_blankline = true,
    dashboard = true,
    which_key = true,
    neoscroll = true,
    ts_rainbow = true,
    ts_autotag = true,
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  polish = function()
    -- set up the file tree to open on startup
    vim.cmd[[
    augroup NEOTREE_AUGROUP
      autocmd!
      au VimEnter * lua vim.defer_fn(function() vim.cmd("Neotree show left reveal_force_cwd") end, 10)
    augroup END
    ]]

    -- set the file tree to close if it's the last window open - maybe this is no longer needed?
    vim.api.nvim_create_autocmd("QuitPre", {callback = function()
      local invalid_win = {}
      local wins = vim.api.nvim_list_wins()
      for _, w in ipairs(wins) do
        local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
        if bufname:match("NvimTree_") ~= nil then
          table.insert(invalid_win, w)
        end
      end
      if #invalid_win == #wins - 1 then
        -- Should quit, so we close all invalid windows.
        for _, w in ipairs(invalid_win) do vim.api.nvim_win_close(w, true) end
        --require('wezterm').close_pane()
      end      
    end})

    -- close all the panes if we quit neovim
    vim.api.nvim_create_autocmd("ExitPre", {callback = function()
      functions.close_pane()
    end})
    
    -- set up the commands for python and wezterm
    vim.api.nvim_create_user_command('Ipython', functions.ipython, {bang = true, nargs = '?'})
    vim.api.nvim_create_user_command('Wezterm', functions.wterm, {bang = true})
    vim.api.nvim_create_user_command('Debugger', functions.pudb, {bang = true})
  end,
}
