JSON = require("json")

URL_CURRENT =
    "https://api.open-meteo.com/v1/forecast?latitude=%f&longitude=%f&current=temperature_2m"

--- Get the weather at a specific location specified by latitude and longitude.
---@param coords [number, number] (1)[latitude, longitude]
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
    req:execute() -- (2)!
end
