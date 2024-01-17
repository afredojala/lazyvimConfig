-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- ToggleTerminal
local Terminal = require("toggleterm.terminal").Terminal
local floating_term = Terminal:new({ direction = "float" })
local horizontal_term = Terminal:new({ direction = "horizontal" })
local vertical_term = Terminal:new({ direction = "vertical" })

function _toggle_floating()
  floating_term:toggle()
end
function _toggle_horizontal()
  horizontal_term:toggle(vim.o.lines * 0.3)
end
function _toggle_vertical()
  vertical_term:toggle(vim.o.columns * 0.5)
end
local terminals = { floating = "i", horizontal = "w", vertical = "t" }
local modes = { "n", "t", "i" }

for orientation, key in pairs(terminals) do
  for _, mode in ipairs(modes) do
    vim.keymap.set(
      mode,
      string.format("<A-%s>", key),
      string.format("<cmd>lua _toggle_%s()<CR>", orientation),
      { noremap = true, silent = true }
    )
  end
end
