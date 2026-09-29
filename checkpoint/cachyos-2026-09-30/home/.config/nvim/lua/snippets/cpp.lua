local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("cf", {
    t({
      "#include <bits/stdc++.h>",
      "using namespace std;",
      "",
      "int main() {",
      "    int n;",
      "    cin >> n;",
      "    ",
    }),
    i(0), -- Cursor will be placed here, on a new line after cin
    t({
		"    ",
      "    return 0;",
      "}",
    }),
  }),
}

