local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then impatient.enable_profile() end

require("core.packer").ensure_packer()
require("plugins")
local load_list = {
  { module = "utils.set_globals" },
  { module = "plugins" },
  { module = "utils.filetypes" },
  { module = "utils.mappings", fn = "tab" },
  -- { module = "utils.hot_reload" },
}

for _, load in ipairs(load_list) do
  local ok, err = pcall(require, load.module)
  if not ok then
    error("Error loading " .. load.module)
  end
end
