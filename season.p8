states_season = {"summer", "cloud"}

function create_season(x, y)
    local c = get_cell(x, y)
    if (is_cell_occupied(c)) then
        draw_over_obj_cors[cocreate(draw_square_cor)] = {x=j*8,y=i*8,s=7,c=8}
        return
    end

    local t = {
        x=c.x,
        y=c.y,
        w=6,
        h=6,
        name="season",
        animt=0,
        state=states_season[1],
        state_index = 1,
        regs={"to_update","to_draw2","holdable", "hit_clock"},
        update=update_season,
        draw=draw_self,
        hit_clock=hit_clock_season,
        immune=false,
        immune_until=0,
        rained = false,
        i=i,
        j=j,
        lives=2,
        draw_hover=draw_hover
    }

    make_immune(t, OBJ_IMMUNE_DUR)

    register_grid_object(t, c.i, c.j)
end

function update_season(o)
    if (o.state == "cloud" and not o.rained) then
        for c in all(get_cells_around(o, 20)) do
            draw_over_obj_cors[cocreate(draw_grid_rain_cor)] = c
        end
        o.rained = true
    end

    -- immunitiy
    o.immune = time() < o.immune_until
end

function hit_clock_season(o, c)
    if (o.immune) then
        -- noop
    else
        make_immune(o, OBJ_IMMUNE_DUR)
        cloud_particles(o.x, o.y-1, 0.5, {3,4}, 8, {7})

        o.state_index = o.state_index % #states_season + 1
        o.state = states_season[o.state_index]
        o.rained = false

        o.lives -= 1
        if o.lives <= 0 then
            cloud_particles(o.x, o.y-1, 0.5, {3,4}, 8, {7})
            deregister_grid_object(o)
        else
            create_text(o.x,o.y,o.lives,7,0)
        end
    end
end

function draw_hover(o)
    for c in all(get_cells_around(o, 20)) do
        pset(c.x-1, c.y-1, 7)
    end
end