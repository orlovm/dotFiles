require("harpoon").setup({
    nav_first_in_list = true,
    projects = {
        ["/home/mikhail/go/src/sfa.git/"] = {
            term = {
                cmds = {
                    'make build_all && make restart',
                }
            }
        }
    }
})
