states_season = {"summer", "cloud"}

function create_season(x, y)
    local t = {
        x=x,
        y=y,
        w=6,
        h=6,
        name="season",
        animt=0,
        state=states_season[1],
        state_index = 1,
        regs={"to_update","to_draw2", "hit_clock"},
        update=update_season,
        draw=draw_self,
        hit_clock=hit_clock_season,
        immune=false,
        immune_until=0,
    }

    make_immune(t, 1)

    register_object(t)
end

function update_season(t)
    -- immunitiy
    t.immune = time() < t.immune_until
end

function hit_clock_season(o, c)
    if (o.immune) then
        -- noop
    else
        make_immune(o, 0.2)
        add_shake(1)

        o.state_index = o.state_index % #states_season + 1
        o.state = states_season[o.state_index] 
    end
end