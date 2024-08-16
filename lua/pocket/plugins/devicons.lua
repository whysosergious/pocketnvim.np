return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup {
      override = {
        html = {
          icon = "",
          color = "#DE8C92",
          name = "html",
        },
        css = {
          icon = "",
          color = "#61afef",
          name = "css",
        },
        js = {
          icon = "",
          color = "#EBCB8B",
          name = "js",
        },
        ts = {
          icon = "ﯤ",
          color = "#519ABA",
          name = "ts",
        },
      },
    }
  end,

  -- "echasnovski/mini.icons",
  -- version = false,
  -- require("mini.icons").setup(),
}
