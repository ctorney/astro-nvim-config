
local M = {}


function M.close_pane()
  -- close the ipython pane
  local args = { "cli", "kill-pane" }
  table.insert(args, "--pane-id")
  table.insert(args, ipython_pane)
  vim.loop.spawn("wezterm", {args=args}) 
  -- close the wezterm pane
  local args = { "cli", "kill-pane" }
  table.insert(args, "--pane-id")
  table.insert(args, wezterm_pane)
  vim.loop.spawn("wezterm", {args=args}) 
end 

function M.ipython(args) 
  -- open or close the ipython pane
  if args["args"] == "close" then
    local args = { "cli", "kill-pane" }
    table.insert(args, "--pane-id")
    table.insert(args, ipython_pane)
    vim.loop.spawn("wezterm", {args=args}) 
  else
    local cmdstring = [[wezterm cli split-pane --percent 30 --right -- ipython -i -c 'import matplotlib;matplotlib.use("module://matplotlib-backend-sixel");matplotlib.rc("figure", figsize=(5, 4));from qbstyles import mpl_style;mpl_style("dark")' ]]
    local handle = io.popen(cmdstring)
    ipython_pane = (handle:read("*a"):gsub("^%s*(.-)%s*$", "%1"))
    -- create a vim function for setting the slime config so that it points to the correct pane
    vim.api.nvim_exec([[
      function! SlimeOverrideConfig()
      let b:slime_config = {}
      let b:slime_config["pane_id"] = ]] .. ipython_pane .. [[ 
      endfunction]], false)
      -- set the slime config
      vim.api.nvim_exec([[:SlimeConfig]], false)  
    end
  return
end

function M.wterm() 
  -- create a new wezterm pane and set the NVIM environment variable to the servername
  -- so that we can use nvr to send buffers to the current nvim instance
  local servername = vim.api.nvim_get_vvar("servername")
  local cmdstring = [[wezterm cli split-pane --percent 20 --bottom -- env NVIM=]] .. servername .. [[ bash -l]]
  local handle = io.popen(cmdstring)
  wezterm_pane = (handle:read("*a"):gsub("^%s*(.-)%s*$", "%1"))
  return
end

function M.pudb() 
  local filename = vim.fn.expand('%')
  local pathname = vim.fn.expand('%:p:h')
  local args = { "cli", "spawn", "--cwd"}
  table.insert(args, pathname)
  table.insert(args, "--")
  table.insert(args, "python")
  table.insert(args, "-m")
  table.insert(args, "pudb")
  table.insert(args, filename)
  vim.loop.spawn("wezterm", {args=args}) 
  return
end
return M
