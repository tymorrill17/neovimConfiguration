-----------------------------
-- DAPs INITIALIZATION
-----------------------------
-- load DAPs defined in ./daps/ folder
for da, _ in
  vim.fs.dir(
    vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "myconfig", "daps")
  )
do
  local status_ok, error_object =
    pcall(require, "myconfig.daps." .. da:gsub("%.lua", ""))
  if not status_ok then
    vim.notify(
      "failed to load DAP: " .. da .. "\n\n" .. "Reason: " .. error_object,
      vim.log.levels.ERROR
    )
  end
end
