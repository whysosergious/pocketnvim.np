return {
  "folke/flash.nvim",
  enabled = true,
  ---@type Flash.Config
  opts = {
    -- labels = "#abcdef",
    modes = {
      -- char = { jump_labels = false },
      -- treesitter = {
      --   label = {
      --     rainbow = { enabled = true },
      --   },
      -- },
      treesitter_search = {
        label = {
          rainbow = { enabled = true },
          -- format = function(opts)
          --   local label = opts.match.label
          --   if opts.after then
          --     label = label .. ">"
          --   else
          --     label = "<" .. label
          --   end
          --   return { { label, opts.hl_group } }
          -- end,
        },
      },
    },
    -- search = { mode = "fuzzy" },
    -- labels = "😅😀🏇🐎🐴🐵🐒",
  },
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
    {
      "<c-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
  },
}
-- {
--   "folke/flash.nvim",
--   event = "VeryLazy",
--   ---@type Flash.Config
--   opts = {},
--   -- stylua: ignore
--   keys = {
--     { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
--     { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
--     { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
--     { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
--     { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
--   },
-- }
