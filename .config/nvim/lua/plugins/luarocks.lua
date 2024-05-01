return {
  {
    "vhyrro/luarocks.nvim",
    config = true,
    lazy = true,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }
    }
  },
}
