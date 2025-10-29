-- lua/plugins/testing.lua
local function has_dep(pkg)
  -- Look upward for the nearest package.json and check deps
  local cwd = vim.fn.getcwd()
  local package_json = vim.fs.find("package.json", { upward = true, path = cwd })[1]
  if not package_json then
    return false
  end

  local ok, json = pcall(function()
    local lines = vim.fn.readfile(package_json)
    local text = table.concat(lines, "\n")
    return vim.json and vim.json.decode(text) or vim.fn.json_decode(text)
  end)
  if not ok or type(json) ~= "table" then
    return false
  end

  local function has(tbl)
    return tbl and (tbl[pkg] ~= nil)
  end
  return has(json.dependencies) or has(json.devDependencies)
end

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- adapters
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-jest",
    },
    ft = { -- lazy-load for relevant buffers
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "svelte",
    },
    opts = function(_, opts)
      opts = opts or {}
      opts.adapters = opts.adapters or {}

      -- Conditionally enable Vitest
      if has_dep("vitest") then
        local ok_vitest, vitest = pcall(require, "neotest-vitest")
        if ok_vitest then
          table.insert(
            opts.adapters,
            vitest({
              -- vitestCommand = "pnpm vitest",  -- set if you use pnpm/yarn
              -- is_test_file = require("neotest-vitest").is_test_file, -- default
            })
          )
        end
      end

      -- Conditionally enable Jest
      if has_dep("jest") or has_dep("@jest/core") then
        local ok_jest, jest = pcall(require, "neotest-jest")
        if ok_jest then
          table.insert(
            opts.adapters,
            jest({
              -- jestCommand = "npm test --",    -- or "pnpm test --"
              -- jestConfigFile = "jest.config.ts",
              -- env = { CI = true },
              -- cwd = function(path) return vim.fn.getcwd() end, -- for monorepos, tweak if needed
            })
          )
        end
      end

      -- Optional UI tweaks
      --opts.discovery = { concurrent = 1 } -- helps in large monorepos
      return opts
    end,
  },
}
