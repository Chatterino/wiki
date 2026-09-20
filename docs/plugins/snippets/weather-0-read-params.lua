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

    local template = "latitude: %f longitude: %f" -- (1)!
    ctx.channel:add_system_message(template:format(latitude, longitude))
end)
