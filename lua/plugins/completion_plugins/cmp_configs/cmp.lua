local present, cmp = pcall(require, "cmp")
if not present then return end

local luasnip = require("luasnip")
local symbols = require("plugins.completion_plugins.cmp_configs.symbols")

local has_copilot, copilot_cmp = pcall(require, "copilot_cmp.comparators")

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end
vim.opt.completeopt = "menuone,noselect"
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  style = {
    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
  },
  formatting = {
    fields = {"kind", "abbr", "menu"},
    format = function(entry, vim_item)
      vim_item.menu_hl_group = "CmpItemKind" .. vim_item.kind
      vim_item.menu = vim_item.kind
      vim_item.abbr = vim_item.abbr:sub(1, 50)
      vim_item.kind = '[' .. symbols[vim_item.kind] .. ']'
      return vim_item
    end
  },
  window = {
    completion = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      scrollbar = "║",
      winhighlight = 'Normal:CmpMenu,FloatBorder:CmpMenuBorder,CursorLine:CmpSelection,Search:None',
      autocomplete = {
        require("cmp.types").cmp.TriggerEvent.InsertEnter,
        require("cmp.types").cmp.TriggerEvent.TextChanged,
      },
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      scrollbar = "║",
    },
  },
  mapping = {
    ["<PageUp>"] = function()
      for _ = 1, 10 do
        cmp.mapping.select_prev_item()(nil)
      end
    end,
    ["<PageDown>"] = function()
      for _ = 1, 10 do
        cmp.mapping.select_next_item()(nil)
      end
    end,
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-s>"] = cmp.mapping.complete({
        config = {
          sources = {
            { name = 'copilot' },
          }
        }
      }),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ["<C-y>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
    ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
  sources = {
    { name = "copilot", group_index = 2 },
    { name = "nvim_lsp", group_index = 2 },
    { name = "path", group_index = 2 },
    { name = 'neorg', group_index = 2 },
  },
  sorting = {
    --keep priority weight at 2 for much closer matches to appear above copilot
    --set to 1 to make copilot always appear on top
    priority_weight = 1,
    comparators = {
      cmp.config.compare.exact,
      has_copilot and copilot_cmp.prioritize or nil,
      has_copilot and copilot_cmp.score or nil,
      cmp.config.compare.offset,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  preselect = cmp.PreselectMode.Item,
})

-- set max height of items
vim.cmd([[ set pumheight=6 ]])
-- set highlights
local highlights = {
  -- type highlights
  CmpItemKindText = { fg = "LightGrey" },
  CmpItemKindFunction = { fg = "#C586C0" },
  CmpItemKindClass = { fg = "Orange" },
  CmpItemKindKeyword = { fg = "#f90c71" },
  CmpItemKindSnippet = { fg = "#565c64" },
  CmpItemKindConstructor = { fg = "#ae43f0" },
  CmpItemKindVariable = { fg = "#9CDCFE", bg = "NONE" },
  CmpItemKindInterface = { fg = "#f90c71", bg = "NONE" },
  CmpItemKindFolder = { fg = "#2986cc" },
  CmpItemKindReference = { fg = "#922b21" },
  CmpItemKindMethod = { fg = "#C586C0" },
  CmpItemKindCopilot = { fg = "#6CC644" },
  -- CmpItemMenu = { fg = "#C586C0", bg = "#C586C0" },
  CmpItemAbbr = { fg = "#565c64", bg = "NONE" },
  CmpItemAbbrMatch = { fg = "#569CD6", bg = "NONE" },
  CmpItemAbbrMatchFuzzy = { fg = "#569CD6", bg = "NONE" },
  CmpMenuBorder = { fg="#263341" },
  CmpMenu = { bg="#10171f" },
  CmpSelection = { bg="#263341" },
}

for group, hl in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, hl)
end
