-- User commands
vim.api.nvim_create_user_command("Russian", function()
	return vim.cmd("set keymap=russian-jcukenwin")
end, { bang = true })

vim.api.nvim_create_user_command("Korean", function()
	return vim.cmd("set keymap=korean")
end, { bang = true })

vim.api.nvim_create_user_command("Greek", function()
	return vim.cmd("set keymap=greek_utf-8")
end, { bang = true })

vim.api.nvim_create_user_command("RMarkdownPreview", function()
	--It prints a lot of stuff and breaks Nvim's UI, I gotta find how to run it in the background
	renderCommand = "R -e 'library(rmarkdown); render(\""
		.. vim.api.nvim_buf_get_name(0)
		.. '", output_format="html_document")\''
	os.execute(renderCommand)
	return
end, { bang = true })
