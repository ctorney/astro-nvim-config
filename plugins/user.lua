return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {"sainnhe/everforest"},
  {"github/copilot.vim",
    event = "InsertEnter",
    autoStart = true,
  },
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
  --{
  --  "michaelb/sniprun",
  --   build = "bash ./install.sh 1",
  --   cmd = "SnipRun",
  --   config = function()
  --      require("sniprun").setup({display = { "Terminal" },})
  --   end,
  --},
  --  keys = {},
  --  opts = {},
  --  cmd = "SnipRun",
  --  config = function()
  --    require("sniprun").setup(display = { "Terminal" })
  --  end,
  --},
  {"jpalardy/vim-slime", 
    ft = {'python', 'lua', 'sh', 'zsh', 'bash', 'ipython'},
    config = function()
      vim.g.slime_target = "neoterm"
      vim.g.slime_default_config = {socket_name="default", target_pane="0"}
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_bracketed_paste = 1
      vim.g.slime_no_mappings = 1
      vim.cmd([[
      nmap <leader>cv <Plug>SlimeConfig
      nmap <leader>cc <Plug>SlimeSend1
      nmap <leader>cn <Plug>SlimeSend2
      nmap <leader>cp <Plug>SlimeSend3
      nmap <leader>cb <Plug>SlimeSend4
      nmap <leader>ca <Plug>SlimeSend5
      nmap <leader>cd <Plug>SlimeSend6
      nmap <leader>ce <Plug>SlimeSend7
      nmap <leader>cf <Plug>SlimeSend8
      nmap <leader>cg <Plug>SlimeSend9
      nmap <leader>ch <Plug>SlimeSend10
      nmap <leader>ci <Plug>SlimeSend11
      nmap <leader>cj <Plug>SlimeSend12
      nmap <leader>ck <Plug>SlimeSend13
      nmap <leader>cl <Plug>SlimeSend14
      nmap <leader>cm <Plug>SlimeSend15
      nmap <leader>cn <Plug>SlimeSend16
      nmap <leader>co <Plug>SlimeSend17
      nmap <leader>cp <Plug>SlimeSend18
      nmap <leader>cq <Plug>SlimeSend19
      nmap <leader>cr <Plug>SlimeSend20
      nmap <leader>cs <Plug>SlimeSend21
      nmap <leader>ct <Plug>SlimeSend22
      nmap <leader>cu <Plug>SlimeSend23
      nmap <leader>cv <Plug>SlimeSend24
      nmap <leader>cw <Plug>SlimeSend25
      nmap <leader>cx <Plug>SlimeSend26
      nmap <leader>cy <Plug>SlimeSend27
      nmap <leader>cz <Plug>SlimeSend28
      ]])
    end,
    


},
  {
  'klafyvel/vim-slime-cells',
  requires = {{'jpalardy/vim-slime', opt=true}},
  ft = {'ipython'},
  config=function ()
    vim.g.slime_target = "neoterm"
    vim.g.slime_cell_delimiter = "^\\s*##"
    vim.g.slime_default_config = {socket_name="default", target_pane="0"}
    vim.g.slime_dont_ask_default = 1
    vim.g.slime_bracketed_paste = 1
   vim.g.slime_no_mappings = 1
    vim.cmd([[
    nmap <leader>cv <Plug>SlimeConfig
    nmap <leader>cc <Plug>SlimeCellsSendAndGoToNext
    nmap <leader>cj <Plug>SlimeCellsNext
    nmap <leader>ck <Plug>SlimeCellsPrev
    ]])
  end
  },
}
