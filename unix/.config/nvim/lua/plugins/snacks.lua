return {
    -- HACK: docs @ https://github.com/folke/snacks.nvim/blob/main/docs
    {
        "folke/snacks.nvim",
        -- priority = 1000,
        -- lazy = false,
        -- NOTE: Options
        opts = {
            -- HACK: read picker docs @ https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
            picker = {
                layout = {
                    -- presets options : "default" , "ivy" , "ivy-split" , "telescope" , "vscode", "select" , "sidebar"
                    -- override picker layout in keymaps function as a param below
                    preset = "ivy", -- defaults to this layout unless overidden
                },
            },
        },
        -- NOTE: Keymaps
        keys = {
            { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>/", LazyVim.pick("grep", { root = false }), desc = "Grep (cwd)" },
            { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader><space>", LazyVim.pick("files", { root = false, hidden = true }), desc = "Find Files (cwd)" },
            { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
            -- find
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>fB", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, desc = "Buffers (all)" },
            { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
            { "<leader>fF", LazyVim.pick("files",{  hidden = true }), desc = "Find Files (Root Dir)" },
            { "<leader>ff", LazyVim.pick("files", { root = false, hidden = true  }), desc = "Find Files (cwd)" },
            { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Files (git-files)" },
            { "<leader>fR", LazyVim.pick("oldfiles"), desc = "Recent" },
            { "<leader>fr", function() Snacks.picker.recent({ filter = { cwd = true }}) end, desc = "Recent (cwd)" },
            { "<leader>fp", function() Snacks.picker.projects({ layout = "default" }) end, desc = "Projects" },
            -- git
            { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (hunks)" },
            { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
            { "<leader>gS", function() Snacks.picker.git_stash({ layout = "default" }) end, desc = "Git Stash" },
            -- Grep
            { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
            { "<leader>sG", LazyVim.pick("live_grep", { hidden = true  }), desc = "Grep (Root Dir)" },
            { "<leader>sg", LazyVim.pick("live_grep", { root = false , hidden = true}), desc = "Grep (cwd)" },
            { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
            { "<leader>sw", LazyVim.pick("grep_word"), desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
            { "<leader>sW", LazyVim.pick("grep_word", { root = false }), desc = "Visual selection or word (cwd)", mode = { "n", "x" } },
            -- search
            { '<leader>s"', function() Snacks.picker.registers({ layout = "default" }) end, desc = "Registers" },
            { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
            { "<leader>sa", function() Snacks.picker.autocmds({ layout = "default" }) end, desc = "Autocmds" },
            { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader>sC", function() Snacks.picker.commands({ layout = "default" }) end, desc = "Commands" },
            { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
            { "<leader>sh", function() Snacks.picker.help({ layout = "default" }) end, desc = "Help Pages" },
            { "<leader>sH", function() Snacks.picker.highlights({ layout = "default" }) end, desc = "Highlights" },
            { "<leader>si", function() Snacks.picker.icons({ layout = "default" }) end, desc = "Icons" },
            { "<leader>sj", function() Snacks.picker.jumps({ layout = "default" }) end, desc = "Jumps" },
            { "<leader>sk", function() Snacks.picker.keymaps({ layout = "default" }) end, desc = "Keymaps" },
            { "<leader>sl", function() Snacks.picker.loclist({ layout = "default" }) end, desc = "Location List" },
            { "<leader>sM", function() Snacks.picker.man({ layout = "default" }) end, desc = "Man Pages" },
            { "<leader>sm", function() Snacks.picker.marks({ layout = "default" }) end, desc = "Marks" },
            { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
            { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
            { "<leader>su", function() Snacks.picker.undo() end, desc = "Undotree" },
            -- ui
            { "<leader>uC", function() Snacks.picker.colorschemes({ layout = "default" }) end, desc = "Colorschemes" },
        },
    },
}
