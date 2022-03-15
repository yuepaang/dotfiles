local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local c = ls.choice_node

local snippets = {
  s(
    "modtest",
    fmt(
      [[
  #[cfg(test)]
  mod test {{
      use super::*;

      {}
  }}

  ]],
      i(0)
    )
  ),
}

return snippets
