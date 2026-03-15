local jdtls = require("jdtls")

-- 1. Locate the jdtls installation manually (bypasses the Mason Registry error)
local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

-- Guard: Stop if jdtls isn't installed yet
if #launcher_jar == 0 then
  vim.notify("JDTLS not found! Run :MasonInstall jdtls", vim.log.levels.ERROR)
  return
end

-- 2. Determine the OS automatically (Mac vs Linux)
local os_config = "config_linux"
if vim.fn.has("mac") == 1 then
  os_config = "config_mac"
elseif vim.fn.has("win32") == 1 then
  os_config = "config_win"
end
local config_dir = jdtls_path .. "/" .. os_config

-- 3. Set the workspace folder (unique per project)
-- This creates a data folder in your nvim cache so it doesn't pollute your project
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    -- Point to the jar we found earlier
    "-jar",
    launcher_jar,

    -- Point to the OS-specific config
    "-configuration",
    config_dir,

    -- Point to the workspace directory
    "-data",
    workspace_dir,
  },

  -- This tells the server to look for git or maven files to find the project root
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),

  -- Here you can attach your keymaps
  on_attach = function(client, bufnr)
    -- Example: enable standard LSP keybindings
    -- local opts = { buffer = bufnr }
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  end,
}

jdtls.start_or_attach(config)
