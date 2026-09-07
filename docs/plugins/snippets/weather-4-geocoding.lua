URL_GEOCODING =
    "https://geocoding-api.open-meteo.com/v1/search?name=%s&count=1&language=en&format=json"

---@alias Place (1){latitude: number, longitude: number, country: string, name: string}

--- Get the coordinates of a location
---@param query string The place to search for
---@param on_success fun(place: Place)
---@param on_error fun(message: string)
local function get_coordinates(query, on_success, on_error)
    local url = URL_GEOCODING:format(urlencode(query))
    local req = c2.HTTPRequest.create(c2.HTTPMethod.Get, url)
    req:on_success(function(res)
        local data = JSON.decode(res:data())
        if --[[(2)!]] data.results == nil or #data.results < 1 then
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
