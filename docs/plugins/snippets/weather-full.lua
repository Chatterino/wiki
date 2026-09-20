JSON = require("json")

URL_CURRENT =
    "https://api.open-meteo.com/v1/forecast?latitude=%.2f&longitude=%.2f&current=temperature_2m"
URL_GEOCODING =
    "https://geocoding-api.open-meteo.com/v1/search?name=%s&count=1&language=en&format=json"

---@alias Place {latitude: number, longitude: number, country: string, name: string}

--- Get the weather at a specific location specified by latitude and longitude.
---@param coords [number, number] [latitude, longitude]
---@param on_success fun(temperature: number)
---@param on_error fun(message: string)
local function get_temperature_at(coords, on_success, on_error)
    local url = URL_CURRENT:format(coords[1], coords[2])
    local req = c2.HTTPRequest.create(c2.HTTPMethod.Get, url)
    req:on_success(function(res)
        on_success(JSON.decode(res:data()).current.temperature_2m)
    end)
    req:on_error(function(res)
        on_error(res:error())
    end)
    req:execute()
end

---@param url string
---@return string
local function urlencode(url)
    url = url:gsub("([^%w ])", function(c)
        return ("%%%02X"):format(string.byte(c))
    end):gsub(" ", "+")
    return url
end

--- Get the coordinates of a location
---@param query string The place to search for
---@param on_success fun(place: Place)
---@param on_error fun(message: string)
local function get_coordinates(query, on_success, on_error)
    local url = URL_GEOCODING:format(urlencode(query))
    local req = c2.HTTPRequest.create(c2.HTTPMethod.Get, url)
    req:on_success(function(res)
        local data = JSON.decode(res:data())
        if data.results == nil or #data.results < 1 then
            on_error("No matching locations found!")
        else
            on_success(data.results[1])
        end
    end)
    req:on_error(function(res)
        on_error(res:error())
    end)
    req:execute()
end

c2.register_command("/get-weather-at", function(ctx)
    if #ctx.words < 3 then
        ctx.channel:add_system_message(
            "Usage: /get-weather-at [latitude] [longitude]")
        return
    end

    local latitude = tonumber(ctx.words[2])
    local longitude = tonumber(ctx.words[3])
    if latitude == nil or longitude == nil then
        ctx.channel:add_system_message("latitude and longitude must be numbers")
        return
    end

    get_temperature_at({latitude, longitude}, function(temperature)
        ctx.channel:add_system_message(("It is currently %.1f°C"):format(
                                           temperature))
    end, function(message)
        ctx.channel:add_system_message("Failed to get weather: " .. message)
    end)
end)

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

c2.register_command("/set-location", function(ctx)
    local query = table.concat(ctx.words, " ", 2)
    get_coordinates(query, function(place)
        local err = save_location(place)
        if err == nil then
            local template = "Updated your location to %s in %s."
            ctx.channel:add_system_message(
                template:format(place.name, place.country))
        else
            ctx.channel:add_system_message(
                "Failed to save your location: " .. err)
        end
    end, function(message)
        ctx.channel:add_system_message("Failed to find your location: " ..
                                           message)
    end)
end)

c2.register_command("/get-weather", function(ctx)
    local place, err = load_location()
    if place == nil then
        ctx.channel:add_system_message(err .. " - did you set your location?")
        return
    end
    get_temperature_at({place.latitude, place.longitude}, function(temperature)
        local template = "It is currently %.1f°C in %s."
        ctx.channel:add_system_message(template:format(temperature, place.name))
    end, function(message)
        ctx.channel:add_system_message("Failed to get weather: " .. message)
    end)
end)
