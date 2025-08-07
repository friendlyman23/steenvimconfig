return 
{
    {
	'echasnovski/mini.nvim',
	config = function()
	    local git = require 'mini.git'
	    git.setup {}

	    local statusline = require 'mini.statusline'
	    statusline.setup { use_icons = true }

	    local bufremove = require 'mini.bufremove'
	    bufremove.setup {}

        local ai = require 'mini.ai'
        ai.setup { n_lines = 500 }

        local surround = require 'mini.surround'
        surround.setup {}
	end
    }
}
