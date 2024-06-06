-- local async = require("plenary.async")
-- local notify = require("notify").async
--
-- async.run(function()
--   notify("Let's wait for this to close").events.close()
--   notify("It closed!")
-- end)
--
--
-- vim.notify(text, "info", {
--   title = "My Awesome Plugin",
--   on_open = function(win)
--     local buf = vim.api.nvim_win_get_buf(win)
--     vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
--   end,
-- })

return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup {

      stages = "fade",
      timeout = 700,
      padding = { left = 0.4, right = 0.4, top = 0.1, bottom = 0.1 },
      max_width = 600,
      max_height = 100,
      level = 1,
      background_colour = "#0f1117",
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },
    }

    local K = {
      cfg_file = "notify.lua",
      rtp = "rcarriga/nvim-notify",

      dismiss_all = {
        map = {
          "n",
          -- { "n", "v", "x" },
          "<leader>da", --check d group..
          "<cmd>:lua require('notify').dismiss()<CR>",
          { desc = "Dismiss all notifications" },
        },
        map2 = '"n" "<leader>da" :lua require("notify").dismiss()<CR>',
        condition = vim.g.leader.mood == "ffs",
        tags = { "notify", "dismiss" },
      },
    }

    PV.plugmaps.notify = K
    vim.api.nvim_set_keymap(unpack(K.dismiss_all.map))
  end,
}
