return {
    {
        'mfussenegger/nvim-lint',
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                python = { "pylint" },
                bash = { "shellcheck" },
                lua = { "luacheck"},
                c = { "cpplint"},
                cpp = { "cpplint" },
            }
        end,
    },
}
