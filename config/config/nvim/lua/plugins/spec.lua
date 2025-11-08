return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 900,
        config = function()
            vim.cmd([[colorscheme catppuccin-mocha]])
        end,
    },

    {
        "mason-org/mason.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("mason").setup {}
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        priority = 10,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                sort = {
                    sorter = "case_sensitive",
                },

                view = {
                    width = 25,
                    side = "right",
                },

                renderer = {
                    group_empty = true,
                },

                filters = {
                    dotfiles = true,
                },

                git = {
                    enable = true,
                },

                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                },

                respect_buf_cwd = true,
            })
        end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        priority = 10,
        opts = {
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            }
        }
    },

    {
    'windwp/nvim-autopairs',
        event = "InsertEnter",
        priority = 10,
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    }
}


