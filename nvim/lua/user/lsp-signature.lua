-- Doing a protected call for formatter to prevent broken config
local signature_status_ok, signature = pcall(require, "lsp_signature")
if not signature_status_ok then
  print("Could not require lsp_signature")
  return
end

signature.setup()
