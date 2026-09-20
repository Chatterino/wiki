--- Saves a location
---@param data Place
---@return nil|string error? If an error occurred, the error message is returned
local function save_location(data)
    local file, err = io.open("location.json", "w")
    if not file then
        return "Failed to open 'location.json': " .. err
    end

    file:write(JSON.encode(data))
    file:close()
    return nil
end

--- Loads a location previously saved
---@return Place? place
---@return string? error
local function load_location()
    local file, err = io.open("location.json", "r")
    if not file then
        return nil, "Failed to open 'location.json': " .. err
    end

    local data = file:read("a")
    file:close()
    return JSON.decode(data), nil
end
