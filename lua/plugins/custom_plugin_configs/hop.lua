require('hop').setup()

local hop_single = function (direction)
  local get_direction = function ()
    if direction == 'backward' then
      return require('hop.hint').HintDirection.BEFORE_CURSOR
    else
      return require('hop.hint').HintDirection.AFTER_CURSOR
    end
  end
  require('hop').hint_patterns({
    direction = get_direction(),
  })
end

vim.keymap.set('n', 'f', function ()
  hop_single('forward')
end, {noremap = true})
