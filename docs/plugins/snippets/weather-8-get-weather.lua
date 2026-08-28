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
