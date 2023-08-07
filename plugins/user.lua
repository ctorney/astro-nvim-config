return {
  {"sainnhe/everforest"},
  -- {"github/copilot.vim",
  --   event = "InsertEnter",
  --   config = function()
  --     vim.cmd([[
  --       imap <silent> <C-p> <Plug>(copilot-prev)
  --       imap <silent> <C-n> <Plug>(copilot-next)
  --       imap <silent> <C-d> <Plug>(copilot-dismiss)
  --       ]]
  --     )
  --   end,
  -- },

  {
    'VonHeikemen/fine-cmdline.nvim',
    lazy = false,
    requires = {
      {'MunifTanjim/nui.nvim'}
    },
    config = function()
      vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true, silent = true})
    end
  },

  {
    'VonHeikemen/searchbox.nvim',
    lazy = false,
    requires = {
      {'MunifTanjim/nui.nvim'}
    },
    config = function()
      vim.keymap.set('n', '<C-f>', ':SearchBoxMatchAll<CR>')
      vim.keymap.set('n', '<C-r>', ':SearchBoxReplace<CR>')
    end
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {enabled = true, 
        auto_trigger = true,
          keymap = {
            accept = "<S-Right>",
            accept_word = "<M-Right>",
            accept_line = false,
            next = "<S-Down>",
            prev = "<S-Up>",
            dismiss = "<C-c>"},
          },
        panel = {enabled = true, 
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-Down>"
          },
        },
      })
    end,
  },
--   {
  --   "zbirenbaum/copilot-cmp",
  --   config = function ()
  --     require("copilot_cmp").setup()
  --   end
  -- },


  {
    "famiu/bufdelete.nvim",
    cmd = {"Bdelete", "Bwipeout"}
  },
  -- {
    --   -- 'numToStr/Comment.nvim',
    --   ft = {'python', 'lua', 'sh', 'zsh', 'bash', 'ipython'},
    --   config = function()
    --       require('Comment').setup()
    --   end
    -- },
  {
    "rcarriga/nvim-notify",
    init = function() require("astronvim.utils").load_plugin_with_func("nvim-notify", vim, "notify") end,
    opts = {
      background_colour = "#000000",
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 175 })
        if not vim.g.ui_notifications_enabled then vim.api.nvim_win_close(win, true) end
        if not package.loaded["nvim-treesitter"] then pcall(require, "nvim-treesitter") end
        vim.wo[win].conceallevel = 3
        local buf = vim.api.nvim_win_get_buf(win)
        if not pcall(vim.treesitter.start, buf, "markdown") then vim.bo[buf].syntax = "markdown" end
        vim.wo[win].spell = false
      end,
    },
    config = require "plugins.configs.notify",
  },

  {
    "jpalardy/vim-slime", 
    lazy = false,
    ft = {'python', 'lua', 'sh', 'zsh', 'bash', 'ipython'},
    config = function()
      vim.g.slime_target = "wezterm"
      vim.g.slime_config = {socket_name="default", pane_id="1"}
      vim.g.slime_dont_ask_default = 0
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_no_mappings = 1
    end,
  },

  {
    'klafyvel/vim-slime-cells',
    requires = {{'jpalardy/vim-slime', opt=true}},
    ft = {'python','ipython'},
    config=function ()
      vim.g.slime_target = "wezterm"
      vim.g.slime_cell_delimiter = "^\\s*##"
      vim.g.slime_default_config = {socket_name="default", pane_id="1"}
      vim.g.slime_dont_ask_default = 0
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_no_mappings = 1
      vim.cmd([[
        nmap <S-CR> <Plug>SlimeCellsSendAndGoToNext
        nmap <C-CR> <Plug>SlimeCellsSendAndGoToNext
        imap <S-CR> <C-o><Plug>SlimeCellsSendAndGoToNext
        imap <C-CR> <C-o><Plug>SlimeCellsSendAndGoToNext
        nmap <leader>cv <Plug>Slimeconfig
        nmap <leader>cc <Plug>SlimeCellsSendAndGoToNext
        nmap <leader>cj <Plug>SlimeCellsNext
        nmap <leader>ck <Plug>SlimeCellsPrev
        ]])
    end
  },

}
