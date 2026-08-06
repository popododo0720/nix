vim.o.background = "dark"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true

local on_ssh = (vim.env.SSH_CONNECTION ~= nil) or (vim.env.SSH_TTY ~= nil)
if on_ssh then
  vim.opt.clipboard = ""
  vim.opt.termguicolors = false
else
  vim.opt.clipboard = "unnamedplus"
  vim.opt.termguicolors = true
end

vim.opt.updatetime = 300
vim.opt.shortmess:append("I")
vim.opt.showcmd = false
vim.opt.title = false

vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = function()
    for _, ms in ipairs({ 10, 100, 300, 600, 1200 }) do
      vim.defer_fn(function()
        pcall(vim.cmd, "redraw!")
      end, ms)
    end
  end,
})

vim.opt.grepprg = "rg --vimgrep --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.mapleader = " "

local function fzf_open()
  if vim.fn.executable("fzf") == 0 then
    vim.notify("fzf not found in PATH", vim.log.levels.ERROR)
    return
  end
  local out = vim.fn.tempname()
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) * 0.5)
  local col = math.floor((vim.o.columns - width) * 0.5)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })
  local cmd = "fzf > " .. vim.fn.shellescape(out)
  if vim.fn.executable("fd") == 1 then
    cmd = "fd --type f --hidden --exclude .git | fzf > " .. vim.fn.shellescape(out)
  end
  vim.fn.termopen({ "bash", "-lc", cmd }, {
    on_exit = function(_, code)
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
      if vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
      if code == 0 then
        local f = io.open(out, "r")
        if f then
          local file = f:read("*l")
          f:close()
          if file and file ~= "" then
            vim.cmd("edit " .. vim.fn.fnameescape(file))
          end
        end
      end
      pcall(os.remove, out)
      vim.cmd("redraw!")
    end,
  })
  vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>e", ":Lexplore<CR>")
vim.keymap.set("n", "<leader>f", fzf_open)
vim.keymap.set("n", "<leader>/", ":grep! ")

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1 })
end)
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1 })
end)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
  end,
})

pcall(function()
  require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    indent = { enable = true },
  })
end)

local capabilities = nil
local blink_ok, blink = pcall(require, "blink.cmp")
if blink_ok then
  blink.setup({
    keymap = { preset = "default" },
    appearance = { nerd_font_variant = "mono" },
    sources = {
      default = { "lsp", "path", "buffer" },
    },
  })
  capabilities = blink.get_lsp_capabilities()
end

local servers = {
  nil_ls = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
      },
    },
  },
  pyright = {},
  yamlls = {},
  bashls = {},
  marksman = {},
}

if vim.lsp.config then
  if capabilities then
    vim.lsp.config("*", { capabilities = capabilities })
  end
  for name, opts in pairs(servers) do
    if capabilities then
      opts = vim.tbl_deep_extend("force", { capabilities = capabilities }, opts)
    end
    vim.lsp.config(name, opts)
    vim.lsp.enable(name)
  end
else
  local ok, lspconfig = pcall(require, "lspconfig")
  if ok then
    for name, opts in pairs(servers) do
      if capabilities then
        opts = vim.tbl_deep_extend("force", { capabilities = capabilities }, opts)
      end
      lspconfig[name].setup(opts)
    end
  end
end
