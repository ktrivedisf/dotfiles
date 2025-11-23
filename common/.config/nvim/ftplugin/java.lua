-- ~/.config/nvim/ftplugin/java.lua
-- Robust jdtls starter with diagnostics

-- 1) Make sure the plugin is actually available
local ok, jdtls = pcall(require, "jdtls")
if not ok then
  vim.notify("[jdtls] nvim-jdtls not found (plugin not loaded?)", vim.log.levels.ERROR)
  return
end

-- 3) Resolve Mason jdtls paths
local data = vim.fn.stdpath("data")        -- e.g. ~/.local/share/nvim
local mason = data .. "/mason/packages/jdtls"
local config_mac   = mason .. "/config_mac"
local config_linux = mason .. "/config_linux"

-- pick the config dir that actually exists
local config_dir = nil
if vim.loop.fs_stat(config_linux) then
  config_dir = config_linux
elseif vim.loop.fs_stat(config_mac) then
  config_dir = config_mac
end

-- find the launcher jar
local launcher = vim.fn.glob(mason .. "/plugins/org.eclipse.equinox.launcher_*.jar")

-- 4) Resolve project root
local root_markers = { "pom.xml", "build.gradle", "settings.gradle", "mvnw", "gradlew", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)

-- Java command (must be 17+; you have 21, which is fine)
local java_cmd = (vim.env.JAVA_HOME and (vim.env.JAVA_HOME .. "/bin/java")) or "java"

-- Early diagnostics (so we see *why* it would bail)
if not root_dir then
  vim.notify("[jdtls] No project root found (need pom.xml / gradle files).", vim.log.levels.WARN)
  return
end
if launcher == "" then
  vim.notify("[jdtls] Launcher JAR not found under: " .. mason .. "/plugins", vim.log.levels.ERROR)
  return
end
if not config_dir then
  vim.notify("[jdtls] Neither config_linux nor config_mac exists under: " .. mason, vim.log.levels.ERROR)
  return
end

-- Workspace dir per project
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = data .. "/jdtls-workspaces/" .. project_name

-- Build command
local cmd = {
  java_cmd,
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=WARNING",
  "-Xms1g",
  "--add-modules=ALL-SYSTEM",
  "--add-opens", "java.base/java.util=ALL-UNNAMED",
  "--add-opens", "java.base/java.lang=ALL-UNNAMED",
  "-jar", launcher,
  "-configuration", config_dir,
  "-data", workspace_dir,
}

-- Start or attach
jdtls.start_or_attach({
  cmd = cmd,
  root_dir = root_dir,
  settings = {
    java = {
      configuration = { updateBuildConfiguration = "interactive" },
    },
  },
})

