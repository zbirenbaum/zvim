vim.api.nvim_create_autocmd({'BufEnter', 'BufRead'}, {
  pattern = {'*.g4'},
  callback = function ()
    vim.o.filetype = 'antlr4'
  end
})

vim.api.nvim_create_autocmd({'BufEnter', 'BufRead'}, {
  pattern = {'*.sol'},
  callback = function ()
    vim.o.cindent = true;
  end
})

vim.api.nvim_create_autocmd({'BufEnter', 'BufRead', 'BufNewFile'}, {
  pattern = {'*.kt', '*.kts'},
  callback = function ()
    vim.bo.filetype = 'kotlin'
  end
})


-- vim.api.nvim_create_autocmd({'BufEnter', 'BufRead', 'BufNewFile'}, {
  -- pattern = {'*.graphql', '*.gql'},
  -- callback = function ()
  --   vim.bo.cindent = true
  --   vim.bo.indentexpr = ''
  --   vim.bo.autoindent = false
  --   vim.bo.lisp = false
  --   vim.bo.smartindent = false
  --   vim.bo.indentkeys="indentkeys=0{,0},0),0[,0],0#,!^F,o,O"
  -- end
-- })

  -- setlocal indentexpr=GetGraphQLIndent()
