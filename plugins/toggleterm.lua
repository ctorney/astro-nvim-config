return {
"akinsho/toggleterm.nvim",
opts = {
  size = vim.o.columns * 0.3,
  open_mapping = [[<F7>]],
  shading_factor = 2,
  direction = "vertical",
  float_opts = {
    border = "curved",
    highlights = { border = "Normal", background = "Normal" },
  },
},
 init = function() 
 --  lazygit:toggle()
 --  vim.cmd([[0TermExec cmd="ipython -c 'import matlplotlib; matplotlib.use('tkagg')'"]])
  --vim.api.nvim_command([[0ToggleTerm]]),
  --vim.api.nvim_command([[1ToggleTerm]])

    vim.api.nvim_exec([[1ToggleTerm
                        2ToggleTerm]], true)

--  vim.cmd([[1ToggleTerm]])
end,

}
