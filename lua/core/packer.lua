local M = {}
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

M.ensure_packer = function()
  local bootstrap = function ()
    fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
    })
    return true
  end

  local needs_install = fn.empty(fn.glob(install_path)) > 0
  local did_bootstrap = needs_install and bootstrap()
  vim.cmd [[packadd packer.nvim]]
  return did_bootstrap
end

return M
