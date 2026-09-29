return {
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lang = "cpp",
      injector = {
        ["cpp"] = {
          before = {
            "#include <bits/stdc++.h>",
            "using namespace std;",
          },
          after = [[
int main() {
    return 0;
}
          ]],
        },
      },
    },
  },
}

