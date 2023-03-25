local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  b.formatting.prettier,
  b.formatting.stylua,

  b.diagnostics.shellcheck,

  b.formatting.google_java_format,
  b.formatting.scalafmt,
  b.diagnostics.flake8,
  b.diagnostics.ruff,
  b.formatting.black,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
