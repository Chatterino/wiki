c2.register_command("/set-location", function(ctx)
    local query = table.concat(ctx.words, " ", 2) -- (1)!
    get_coordinates(query, function(place)
        local template = "Your location is %s in %s."
        ctx.channel:add_system_message(
            template:format(place.name, place.country))
    end, function(message)
        ctx.channel:add_system_message("Failed to find your location: " ..
                                           message)
    end)
end)
