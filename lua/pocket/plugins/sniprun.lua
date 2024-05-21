return {
  'michaelb/sniprun',
  branch = 'master',

  build = 'cargo build --release',
  -- do 'sh install.sh 1' if you want to force compile locally
  -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

  config = function()
    require('sniprun').setup {
      -- your options
      binary_path = './target/release/sniprun',
      selected_interpreters = { 'JS_TS_deno' },
      repl_enable = { 'JS_TS_deno' },
      live_display = {
        'VirtualText',
      },
      display = {
        'VirtualTextOk',
        'VirtualTextErr',
      },
    }
  end,
}
