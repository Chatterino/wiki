--- Encode a string to be used in a URL query
---@param url string
---@return string
local function urlencode(url)
    url = url:gsub("([^%w ])", function(c)
        return ("%%%02X"):format(c:byte()) -- (1)!
    end):gsub(" ", "+") -- (2)!
    return url
end
