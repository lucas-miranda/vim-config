lua << EOF

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
}
EOF

nnoremap <Leader>g :Telescope find_files<CR>
nnoremap <Leader>t :Telescope live_grep<CR>
nnoremap <Leader>b :Telescope buffers<CR>
nnoremap <Leader>T :Telescope help_tags<CR>
