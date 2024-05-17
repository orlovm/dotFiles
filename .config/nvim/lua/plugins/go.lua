return {
	{
		"edolphin-ydf/goimpl.nvim",
		keys = {
			{ "<leader>im", function () require'telescope'.extensions.goimpl.goimpl{} end, { noremap = true, silent = true } }
		},
	},
}
