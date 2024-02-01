return {
  {"sainnhe/everforest"},
  {"stevearc/vim-arduino",
    ft = {'arduino'},
    config = function()
      vim.g.arduino_autoformat_on_save = 1
      vim.cmd([[
        nmap <leader>au <Plug>ArduinoUpload
        nmap <leader>ac <Plug>ArduinoCompile
        nmap <leader>as <Plug>ArduinoSerial
        nmap <leader>av <Plug>ArduinoVerify

        ]])
    end
  },

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
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = function(_, opts)
      local utils = require "astronvim.utils"
      return utils.extend_tbl(opts, {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = false, -- position the cmdline and popupmenu together
          long_message_to_split = false, -- long messages will be sent to a split
          inc_rename = utils.is_available "inc-rename.nvim", -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end,
    init = function() vim.g.lsp_handlers_enabled = false end,
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      if not opts.bottom then opts.bottom = {} end
      table.insert(opts.bottom, {
        ft = "noice",
        size = { height = 0.4 },
        filter = function(_, win) return vim.api.nvim_win_get_config(win).relative == "" end,
      })
    end,
  },
  -- lazy.nvim
  -- {
  --   'VonHeikemen/fine-cmdline.nvim',
  --   lazy = false,
  --   requires = {
  --     {'MunifTanjim/nui.nvim'}
  --   },
  --   config = function()
  --     vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true, silent = true})
  --   end
  -- },

  {
    'Lilja/zellij.nvim',
    lazy = false,
    enable = true,
    config = function()
      require("zellij").setup({
        vimTmuxNavigatorKeyBinds = true,})
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
    event = "BufRead",
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
            open = "<C-p>"
          },
        },
      })
    end,
  },

  -- Lazy
-- {
--   "jackMort/ChatGPT.nvim",
--     event = "VeryLazy",
--     config = function()
--       require("chatgpt").setup({
--   api_key_cmd = nil,
--     yank_register = "+",
--     chat = {
--       welcome_message = [[ 
--       Welcome to ChatGPT 4. Please ask me a question. -- changed
--       ]],
--       }
--       }
--       )
--     end,
--     dependencies = {
--       "MunifTanjim/nui.nvim",
--       "nvim-lua/plenary.nvim",
--       "nvim-telescope/telescope.nvim"
--     }
-- },
  {
    "ctorney/gp.nvim",
    cmd = {"GpChatNew", "GpChatToggle", "GpChatFinder", "GpExplain","GpEmail"},
    config = function()
      require("gp").setup({
        chat_user_prefix = "🗨",
	      chat_assistant_prefix = "🤖",
	      chat_confirm_delete = false,
	      style_highlight = "None",
	      style_popup_border = "rounded",
	      style_popup_left_margin = 1,
	      style_popup_title = " ChatGPT 4 ",
	      style_popup_winhighlight = "Normal:Normal,FloatBorder:Normal,FloatTitle:Normal,WinBar:Normal",
	      toggle_target = "popup",
	      agents = {
          -- Disable ChatGPT 3.5
          {
            name = "ChatGPT3-5",
            chat = false,  -- just name would suffice
            command = false,   -- just name would suffice
          },
          {
            name = "ChatGPT4",
            chat = true,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-4-1106-preview", temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are a general AI assistant.\n\n"
              .. "The user provided the additional info about how they would like you to respond:\n\n"
              .. "- If you're unsure don't guess and say you don't know instead.\n"
              .. "- Ask question if you need clarification to provide better answer.\n"
              .. "- Think deeply and carefully from first principles step by step.\n"
              .. "- Make your response clear and brief.\n"
              .. "- Do not give advice unless it has been requested.\n"
              .. "- If asked for code only provide the code and don't provide any explanation.\n"
          },
    },
	    	-- chat_model = { model = "gpt-4", temperature = 1.1, top_p = 1 },
     		-- command_model = { model = "gpt-4", temperature = 1.1, top_p = 1 },
	      -- chat_custom_instructions = "When providing code just give the code and don't explain it.\n"
	              -- .. "Only provide the raw code without markdown markers.\n",
        -- hooks = {
        --   Explain = function(gp, params)
        --     local template = "I have the following code from {{filename}}:\n\n"
        --     .. "```{{filetype}}\n{{selection}}\n```\n\n"
        --     .. "Please respond by explaining the code above."
        --     gp.Prompt(params, gp.Target.popup, nil, gp.config.command_model,
        --       template, gp.config.chat_system_prompt)
        --   end,
        --   Email = function(gp, params)
        --     local template = "The text below is from an email chain with the most recent message at the top.\n"
        --           .. "The text of all previous messages start with the > character. \n"
        --           .. "Write an email response to the chain as though you were Colin Torney, "
        --           .. "a Professor of Applied Mathematics. \n\n"
        --           .. "If there is any text at the start that does not begin with > use this text "
        --           .. "as further instruction for the email response. \n"
        --           .. "Return only the text of the email. \n"
        --           .. "Try not to repeat text from the email chain in your response. \n"
        --           .. "Start the email with Hi and the first name of the recipient and end with Best wishes, Colin. \n"
        --           .. "Compose the response in a terse and very concise style and sign off with first name only. \n\n"
        --           .. "```{{selection}}\n```\n\n"
        --     params.range = 2
        --     params.line1 = 1
        --     params.line2 = 100
        --     local chat_model = { model = "gpt-4", temperature = 0.7, top_p = 1 }
        --     gp.Prompt(params, gp.Target.prepend, nil, gp.config.command_model,
        --       template, gp.config.chat_system_prompt)
        --   end,
        -- }
      })
    end,
  },

  {
    "ggandor/leap.nvim",
    enabled = true,
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },

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

  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lualine").setup {
	 --      options = {
		--       theme = "everforest",
		--       component_separators = "|",
		--       -- section_separators = { left = "", right = "" },
	 --      },
	 --      sections = {
		--       lualine_a = { { "mode", right_padding = 2 } },
		--       lualine_b = {  { "filename", path=2} },
		--       lualine_c = { "hostname","branch", { "diff", colored = true } },
		--       lualine_x = {"diagnostics"},
		--       lualine_y = { "filetype", "progress" },
		--       lualine_z = { { "location", left_padding = 2 } },
	 --      },
	 --      inactive_sections = {
		--       lualine_a = { "filename" },
		--       lualine_b = {},
		--       lualine_c = {},
		--       lualine_x = {},
		--       lualine_y = {},
		--       lualine_z = {},
	 --      },
	 --      tabline = {
		--       lualine_a = {
		-- 	      {
		-- 		      "buffers",
		-- 		      separator = { left = "", right = "" },
		-- 		      right_padding = 2,
		-- 		      symbols = { alternate_file = "" },
		-- 	      },
		--       },
	 --      },
  --     }
  --     --      -- LSP clients attached to buffer
  --     --      require("lualine").setup({
  --     --        options = {
  --     --          theme = "everforest",
  --     --          icons_enabled = true,
  --     --          section_separators = {"", ""},
  --     --          component_separators = {"", ""},
  --     --          disabled_filetypes = {},
  --     --        },
  --     --        sections = {
  --     --          lualine_a = {"mode"},
  --     --          lualine_b = {"hostname"},
  --     --          lualine_c = {{"filename",path=2}},
  --     --          lualine_x = {"clients_lsp","encoding", "fileformat", "filetype"},
	 --    --
  --     --          lualine_y = {"progress"},
  --     --          lualine_z = {"location"},
  --     --        },
  --     --        inactive_sections = {
  --     --          lualine_a = {},
  --     --          lualine_b = {},
  --     --          lualine_c = {"filename"},
  --     --          lualine_x = {"location"},
  --     --          lualine_y = {},
  --     --          lualine_z = {},
  --     --        },
  --     --        tabline = {
	 --    -- 	lualine_a = {
	 --    -- 		{
	 --    -- 			"buffers",
	 --    -- 			separator = { left = "", right = "" },
	 --    -- 			right_padding = 2,
	 --    -- 			symbols = { alternate_file = "" },
	 --    -- 		},
	 --    -- 	},
	 --    -- },
  --     --        extensions = {},
  --     --      })
  --   end,
  --   requires = {
  --     "kyazdani42/nvim-web-devicons",
  --     opt = true,
  --   },
  -- },

  {
    "jpalardy/vim-slime", 
    lazy = false,
    ft = {'python', 'lua', 'sh', 'zsh', 'bash', 'ipython'},
    config = function()
      -- vim.g.slime_target = "tmux"
      -- vim.g.slime_config = {socket_name="default", target_pane="{right}"}
      vim.g.slime_target = "zellij"
      vim.g.slime_config = {session_id="current", relative_pane="right"} --, relative_move_back="left"}
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_no_mappings = 1
    end,
  },

  {
    'klafyvel/vim-slime-cells',
    requires = {{'jpalardy/vim-slime', opt=true}},
    ft = {'python','ipython'},
    config=function ()
      -- vim.g.slime_target = "tmux"
      -- vim.g.slime_default_config = {socket_name="default", target_pane="{right}"}
      vim.g.slime_target = "zellij"
      vim.g.slime_cell_delimiter = "^\\s*##"
      vim.g.slime_default_config = {session_id="current", relative_pane="right", relative_move_back="left"}
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_no_mappings = 1
      vim.cmd([[
        nmap <S-CR> <Plug>SlimeCellsSendAndGoToNext
        nmap <C-CR> <Plug>SlimeCellsSendAndGoToNext
        xmap <S-CR> <Plug>SlimeRegionSend
        xmap <C-CR> <Plug>SlimeRegionSend
        imap <S-CR> <C-o><Plug>SlimeCellsSendAndGoToNext
        imap <C-CR> <C-o><Plug>SlimeCellsSendAndGoToNext
        nmap <leader>cv <Plug>Slimeconfig
        nmap <leader>cc <Plug>SlimeCellsSendAndGoToNext
        nmap <leader>cj <Plug>SlimeCellsNext
        nmap <leader>ck <Plug>SlimeCellsPrev
        ]])
    end
  },
  {
    'lervag/vimtex',
    ft = {'tex'},
    config = function ()
      vim.g.vimtex_view_general_viewer = 'sioyek'
      vim.g.vimtex_view_enabled = 1
      -- set line wrapping on
      vim.g.wrap = true,
      vim.cmd([[
      nmap <Up> gk
      nmap <Down> gj
      imap <Up> <C-o>gk
      imap <Down> <C-o>gj
      vmap <Up> gk
      vmap <Down> gj
      nmap <leader>vc :VimtexCompile<CR>
      nmap <leader>vv :VimtexView<CR>
      nmap <leader>vt :VimtexTocToggle<CR>
      ]])
    end
  },

  -- {
  --   'dmadisetti/airlatex.vim',
  --   lazy = false,
  --   cmd = {"AirLatex", "AirLatexStop", "AirLatexToggle"},
  --   -- event = "InsertEnter",
  --   config = function ()
  --     vim.g.AirLatexCookieDB = "/home/ctorney/snap/firefox/common/.mozilla/firefox/w9ewhbb7.default-release/cookies.sqlite"
  --     -- vim.g.AirLatexCookie = "cookies:_ga=GA1.2.198190938.1587589289"
  --     -- vim.g.AirLatexCookieKey = "_ga"
  --     vim.g.AirLatexLogLevel = "DEBUG"
  --     vim.g.AirLatexLogFile = "/tmp/airlatex.log"
  --   end
  -- },

}
