lua << EOF
local actions = require "telescope.actions"
local previewers = require "telescope.previewers"
local sorters = require "telescope.sorters"

-- custom pickers
local conf = require("telescope.config").values
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"

-- live grep with ag (silver search)
--[[
function ag_live_grep(results)
    local opts = {
    }

    pickers.new(
        opts,
        {
            prompt_title = "Live Grep (Ag)",
            finder = finders.new_job(
                function(prompt)

                end,
                opts.entry_maker or make_entry.gen_from_vimgrep(opts),
                opts.max_results,
                opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
            )
        }
    )

--[[
  pickers.new(opts, {
    prompt_title = 'Custom Picker',
    finder = finders.new_table(results),
    sorter = sorters.fuzzy_with_index_bias(),
    attach_mappings = function(_, map)
      -- Map "<cr>" in insert mode to the function, actions.set_command_line
      map('i', '<cr>', actions.set_command_line)

      -- If the return value of `attach_mappings` is true, then the other
      -- default mappings are still applies.
      --
      -- Return false if you don't want any other mappings applied.
      --
      -- A return value _must_ be returned. It is an error to not return anything.
      return true
    end,
  }):find()
end
]]

require("telescope").setup{
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
        file_sorter = sorters.get_fzy_sorter, --sorters.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = sorters.get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = true,
        use_less = true,
        path_display = {},
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-l>"] = actions.select_default,
                ["<C-h>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical
            }
        },

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = previewers.buffer_previewer_maker
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
    }
}
EOF

nnoremap <Leader>g :Telescope find_files<CR>
nnoremap <Leader>t :Telescope live_grep<CR>
nnoremap <Leader>b :Telescope buffers<CR>
nnoremap <Leader>T :Telescope help_tags<CR>
