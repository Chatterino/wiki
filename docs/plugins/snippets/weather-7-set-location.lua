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
