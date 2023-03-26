local c = vim.cmd
local d = vim.diagnostic
local l = vim.lsp
local npc = vim.F.npcall
local v = vim.v
local reverse = string.reverse
local foldmarker, thou, culright, ffi, C
local M = {}
local ns = vim.api.nvim_create_namespace('Folding')
local prev_level = -1
vim.fn.sign_define('FoldOpened', {
  string = ''
})
vim.fn.sign_define('FoldClosed', {
  string = ''
})
--- Return line number in configured format.
function M.lnumfunc(args)
  if not args.rnu and not args.nu then return "" end
  if v.virtnum ~= 0 then return "%=" end

  local lnum = args.rnu and (v.relnum > 0 and v.relnum
  or (args.nu and v.lnum or 0)) or v.lnum

  if thou and lnum > 999 then
    lnum = reverse(lnum):gsub("%d%d%d", "%1"..thou):reverse():gsub("^%"..thou, "")
  end

  if v.relnum == 0 and not culright and args.rnu then
    return lnum.."%="
  else
    return "%="..lnum
  end
end

function M.foldfunc(args)
  -- local width = 0;
  if not vim.o.signcolumn then return end
  local width = C.compute_foldcolumn(args.wp, 0)
  if width == 0 then return "" end
  local foldinfo = C.fold_info(args.wp, v.lnum)
  local string = v.relnum > 0 and "%#FoldColumn#" or "%#CursorLineFold#"
  local level = foldinfo.level
  local closed = foldinfo.lines > 0
  local first_level = level - width - (closed and 1 or 0) + 1
  if first_level < 1 then first_level = 1 end
  -- For each column, add a foldopen, foldclosed, foldsep or padding char
  local range = level < width and level or width
  local col = 1
  if closed and (col <= level) then
    string = ''
  elseif foldinfo.start == v.lnum and first_level + col > foldinfo.llevel then
    string = ''
    vim.fn.sign_place(0, 'X', 'FoldOpened', 1, {
      lnum = v.lnum,
      priority = 1000,
    })
  else
    string = ' '
  end
end
-- Return true if the statuscolumn is not empty.
function M.not_empty(args)
  return C.win_col_off(args.wp) > 0
end

--- Create new fold by middle-cliking the range.
local function create_fold(args)
  if foldmarker then
    c("norm! zf"..foldmarker.."G")
    foldmarker = nil
  else
    foldmarker = args.mousepos.line
  end
end

local function fold_click(args, open, other)
  -- Create fold on middle click
  if args.button == "m" then
    create_fold(args)
    if other then return end
  end
  foldmarker = nil

  if args.button == "l" then  -- Open/Close (recursive) fold on (Ctrl)-click
    if open then
      c("norm! z"..(args.mods:find("c") and "O" or "o"))
    else
      c("norm! z"..(args.mods:find("c") and "C" or "c"))
    end
  elseif args.button == "r" then  -- Delete (recursive) fold on (Ctrl)-right click
    c("norm! z"..(args.mods:find("c") and "D" or "d"))
  end
end

--- Handler for clicking '+' in fold column.
function M.foldclose_click(args)
  npc(fold_click, args, true)
end

--- Handler for clicking '-' in fold column.
function M.foldopen_click(args)
  npc(fold_click, args, false)
end

--- Handler for clicking ' ' in fold column.
function M.foldother_click(args)
  npc(fold_click, args, false, true)
end

--- Handler for clicking a Diagnostc* sign.
function M.diagnostic_click(args)
  if args.button == "l" then
    d.open_float()       -- Open diagnostic float on left click
  elseif args.button == "m" then
    l.buf.code_action()  -- Open code action on middle click
  end
end

--- Handler for clicking a GitSigns* sign.
function M.gitsigns_click(args)
  if args.button == "l" then
    require("gitsigns").preview_hunk()
  elseif args.button == "m" then
    require("gitsigns").reset_hunk()
  elseif args.button == "r" then
    require("gitsigns").stage_hunk()
  end
end

--- Toggle a (conditional) DAP breakpoint.
function M.toggle_breakpoint(args)
  local dap = npc(require, "dap")
  if not dap then return end
  if args.mods:find("c") then
    vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
      dap.set_breakpoint(input)
    end)
  else
    dap.toggle_breakpoint()
  end
end

--- Handler for clicking the line number.
function M.lnum_click(args)
  if args.button == "l" then
    -- Toggle DAP (conditional) breakpoint on (Ctrl-)left click
    M.toggle_breakpoint(args)
  elseif args.button == "m" then
    c("norm! yy")  -- Yank on middle click
  elseif args.button == "r" then
    if args.clicks == 2 then
      c("norm! dd")  -- Cut on double right click
    else
      c("norm! p")   -- Paste on right click
    end
  end
end

function M.init(cfg)
  thou = cfg.thousands
  culright = cfg.relculright
  ffi = require("plugins.custom_plugin_configs.statuscol.ffidef")
  C = ffi.C
end

return M
