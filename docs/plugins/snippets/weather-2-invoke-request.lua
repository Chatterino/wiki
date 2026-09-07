c2.register_command("/get-weather-at", function(ctx)
    -- ...
    local latitude = tonumber(ctx.words[2])
    local longitude = tonumber(ctx.words[3])
    -- ...

    get_temperature_at({latitude, longitude}, function(temperature)
        ctx.channel:add_system_message(("It is currently %.1f°C"):format(
                                           temperature))
    end, function(message)
        ctx.channel:add_system_message("Failed to get weather: " .. message)
    end)
end)
