require('code_runner').setup({
	project_dir = "./",

	-- put here the commands by filetype
	filetype = {
		java = "javac -d bin/ $dir/$fileName && cd bin/ && java $fileNameWithoutExt",
		python = "python3 -u",
		typescript = "deno run",
		rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
	},


})
