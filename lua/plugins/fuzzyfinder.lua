
return {
    --  Note!  Install 'fd' and set FZF_DEFAULT_COMMAND
    --  FZF_DEFAULT_COMMNAND="fd --type f --hidden --follow --exclude .git"

    --set rtp+=~/.fzf
    --if has('win32')
        --'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'sh install --all' }
    --else
        --'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    --endif

    --'junegunn/fzf.vim',

    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
        keys = {
            { "<leader>g", "<cmd>Telescope find_files<cr>" },
            { "<leader>t", "<cmd>Telescope live_grep<cr>" },
            { "<leader>b", "<cmd>Telescope buffers<cr>" },
            { "<leader>T", "<cmd>Telescope help_tags<cr>" },
        },
        opts = {
            defaults = {
                vimgrep_arguments = {
                    "ag",
                    "--vimgrep",
                    "--all-types",
                    "--numbers",
                    "--column",
                    "--filename",
                    "--nocolor",
                    "--noheading",
                    "--smart-case",
                    "--literal",
                },
                prompt_prefix = "> ",
                selection_caret = "> ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "descending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        mirror = false,
                    },
                    vertical = {
                        mirror = false,
                    }
                },
                --file_sorter = sorters.get_fzy_sorter, --sorters.get_fuzzy_file,
                file_ignore_patterns = {},
                --generic_sorter = sorters.get_generic_fuzzy_sorter,
                winblend = 0,
                border = {},
                borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
                color_devicons = true,
                use_less = true,
                path_display = {},
                set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                --file_previewer = previewers.vim_buffer_cat.new,
                --grep_previewer = previewers.vim_buffer_vimgrep.new,
                --qflist_previewer = previewers.vim_buffer_qflist.new,

                mappings = {
                    i = {
                        ["<C-j>"] = function(...)
                            require("telescope.actions").move_selection_next(...)
                        end,
                        ["<C-k>"] = function(...)
                            require("telescope.actions").move_selection_previous(...)
                        end,
                        ["<C-l>"] = function(...)
                            require("telescope.actions").select_default(...)
                        end,
                        ["<C-h>"] = function(...)
                            require("telescope.actions").select_horizontal(...)
                        end,
                        ["<C-v>"] = function(...)
                            require("telescope.actions").select_vertical(...)
                        end,
                    }
                },

                -- Developer configurations: Not meant for general override
                --buffer_previewer_maker = previewers.buffer_previewer_maker
            },
            pickers = {
                find_files = {
                    find_command = {
                        "fd",
                        "--type", "file",
                        "--hidden",
                        "--follow",
                        "--no-ignore-vcs",
                        "--exclude", ".git"
                    }
                }
            },
        },
        config = function(_, opts)
            local telescope = require "telescope"

            --local actions = require "telescope.actions"
            local previewers = require "telescope.previewers"
            local sorters = require "telescope.sorters"

            -- custom pickers
            --local conf = require("telescope.config").values
            --local pickers = require "telescope.pickers"
            --local finders = require "telescope.finders"
            --local make_entry = require "telescope.make_entry"

            opts.defaults.file_sorter = sorters.get_fzy_sorter --sorters.get_fuzzy_file,
            opts.defaults.generic_sorter = sorters.get_generic_fuzzy_sorter

            opts.defaults.file_previewer = previewers.vim_buffer_cat.new
            opts.defaults.grep_previewer = previewers.vim_buffer_vimgrep.new
            opts.defaults.qflist_previewer = previewers.vim_buffer_qflist.new

            opts.defaults.buffer_previewer_maker = previewers.buffer_previewer_maker

            telescope.setup(opts)
        end,
    }
}
