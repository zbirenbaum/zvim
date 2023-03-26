local types = require("cmp.types")
local misc = require("cmp.utils.misc")

local compare = {}
W = {}
W.TypeParameter = 1
W.Method = 2
W.Variable = 3
W.Function = 4
W.Constructor = 5
W.Field = 6
W.Class = 6
W.Interface = 8
W.Module = 9
W.Property = 10
W.Unit = 11
W.Value = 12
W.Enum = 13
W.Keyword = 14
W.Snippet = 15
W.Color = 16
W.File = 17
W.Reference = 18
W.Folder = 19
W.EnumMember = 20
W.Constant = 21
W.Struct = 22
W.Event = 23
W.Operator = 24
W.Text = 1
--
compare.disable_snip = function(entry1, entry2)
  local kind1 = entry1:get_kind()
  local kind2 = entry2:get_kind()
  if kind1 ~= kind2 then
    if kind1 == types.lsp.CompletionItemKind.Snippet then
      return false
    end
    if kind2 == types.lsp.CompletionItemKind.Snippet then
      return true
    end
  end
end

compare.disable_text = function(entry1, entry2)
  -- local kind1 = entry1:get_kind()
  -- local kind2 = entry2:get_kind()
  local kind1 = W.kind1
  local kind2 = W.kind1
  if kind1 ~= kind2 then
    if kind1 == types.lsp.CompletionItemKind.Text then
      return false
    end
    if kind2 == types.lsp.CompletionItemKind.Text then
      return true
    end
  end
end

compare.kind_sort = function(entry1, entry2)
  local kind1 = entry1:get_kind()
  print(kind1)
  local kind2 = entry2:get_kind()
  if kind1 ~= kind2 then
    local diff = kind1 - kind2
    if diff < 0 then
      return true
    elseif diff > 0 then
      return false
    end
  end
end

return compare
