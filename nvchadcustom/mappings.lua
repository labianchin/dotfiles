---@type MappingsTable
local M = {}

M.general = {
  -- https://nvchad.com/docs/config/mappings
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>w"] = {":w <CR>", "write"},
    ["<leader>q"] = {":q <CR>", "quit"},
    ["<leader>r"] = {":luafile $MYVIMRC <CR>", "reload"},
    ["<leader>ew"] = {":e %%", "editor current file"},



    -- https://github.com/nvim-telescope/telescope.nvim#default-mappings
    ["<leader>p"] = {":Telescope find_files<CR>", "find files"},
    ["<leader>b"] = {":Telescope buffers<CR>", "find files"},
    ["<leader>fg"] = {":Telescope live_grep<CR>", "find files"},
    ["<leader>fh"] = {":Telescope help_tags<CR>", "find files"},

    -- https://github.com/nvim-tree/nvim-tree.lua#commands
    ["<C-e>"] = {"<cmd> NvimTreeFocus <CR>", "Focus NvimTree"},
    ["<C-t>"] = {"<cmd> tabnew <CR>", "new tab"},


    -- todo reload
--nnoremap <silent> <leader>r :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

    ["<leader>nf"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "lsp formatting",
    },
  },
}

-- more keybinds!

return M
