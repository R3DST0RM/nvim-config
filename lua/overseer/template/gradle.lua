-- ~/.config/nvim/lua/overseer/template/gradle.lua
local constants = require("overseer.constants")
local TAG = constants.TAG

---@param opts overseer.SearchParams
---@return nil|string
local function get_gradle_file(opts)
  return vim.fs.find(
    { "settings.gradle.kts", "settings.gradle", "build.gradle.kts", "build.gradle" },
    { upward = true, type = "file", path = opts.dir }
  )[1]
end

---@param dir string
---@return nil|string cmd The command to run (wrapper path or "gradle")
local function get_gradle_cmd(dir)
  local is_windows = vim.fn.has("win32") == 1
  local wrapper = vim.fs.joinpath(dir, is_windows and "gradlew.bat" or "gradlew")
  if vim.fn.executable(wrapper) == 1 then
    return wrapper
  end
  if vim.fn.executable("gradle") == 1 then
    return "gradle"
  end
  return nil
end

local commands = {
  { args = { "build" }, tags = { TAG.BUILD } },
  { args = { "assemble" }, tags = { TAG.BUILD } },
  { args = { "run" }, tags = { TAG.RUN } },
  { args = { "test" }, tags = { TAG.TEST } },
  { args = { "check" }, tags = { TAG.TEST } },
  { args = { "clean" }, tags = { TAG.CLEAN } },
  { args = { "dependencies" } },
  { args = { "tasks", "--all" } },
  { args = { "build", "--refresh-dependencies" } },
}

---@type overseer.TemplateFileProvider
return {
  cache_key = function(opts)
    return get_gradle_file(opts)
  end,
  generator = function(opts)
    local gradle_file = get_gradle_file(opts)
    if not gradle_file then
      return "No Gradle build file found"
    end
    local gradle_dir = vim.fs.dirname(gradle_file)
    local cmd = get_gradle_cmd(gradle_dir)
    if not cmd then
      return "No gradlew wrapper or 'gradle' executable found"
    end
    local display = cmd == "gradle" and "gradle" or "gradlew"

    local ret = {}
    for _, command in ipairs(commands) do
      table.insert(ret, {
        name = string.format("%s %s", display, table.concat(command.args, " ")),
        tags = command.tags,
        builder = function()
          return {
            cmd = { cmd },
            args = command.args,
            cwd = gradle_dir,
            default_component_params = {
              errorformat = [[%f:%l:%c: error: %m]]
                .. [[,%f:%l:%c: warning: %m]]
                .. [[,%f:%l: error: %m]]
                .. [[,%f:%l: warning: %m]],
            },
          }
        end,
      })
    end
    return ret
  end,
}
