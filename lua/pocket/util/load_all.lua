-- ~/.config/nvim/lua/load-all.lua
local function load_all_files(dir)
    local handle = vim.loop.fs_scandir(dir)
    local loaded_files = {}

    if not handle then
        return
    end

    local name, typ, success, res
    while handle do
        name, typ = vim.loop.fs_scandir_next(handle)
        if not name then
            break
        end

        if typ == "file" and name:sub(-4) == ".lua" then
            local module_name = name:sub(1, -5)
            success, res = pcall(require, dir .. '.' .. module_name)
            if success then
                loaded_files[module_name] = res
            else
                print("Error loading module '" .. module_name .. "': " .. res)
            end
        end
    end

    return loaded_files
end

return load_all_files

