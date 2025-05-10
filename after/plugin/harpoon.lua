local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add to harpoon" })

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Open harpoon window 1" })
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end, { desc = "Open harpoon window 2" })
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end, { desc = "Open harpoon window 3" })
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end, { desc = "Open harpoon window 4" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Open prev harpoon window" })
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Open next harpoon window" })

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })