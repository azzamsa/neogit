local cli = require("neogit.lib.git.cli")
local util = require("neogit.lib.util")

local M = {}

function M.pull_interactive(remote, branch, args)
  return cli.pull.args(remote or "", branch or "").args(args).call_interactive()
end

local function update_unpulled(state)
  if not state.upstream.branch then
    vim.notify("No upstream branch")
    return
  end

  local result = cli.log.oneline.for_range("..@{upstream}").show_popup(false).call()

  state.unpulled.items = util.map(result, function(x)
    return { name = x }
  end)
end

function M.register(meta)
  meta.update_unpulled = update_unpulled
end

return M
