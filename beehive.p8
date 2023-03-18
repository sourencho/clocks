function create_beehive(x, y)
    local c = get_cell(x, y)
    if (is_cell_invalid(c)) then
        draw_over_obj_cors[cocreate(draw_square_cor)] = {x=j*8,y=i*8,s=7,c=8}
        return
    end

    local t = {
        x=x,
        y=y,
        w=4,
        h=4,
        animt=0,
        name="beehive",
        state="idle",
        regs={"to_update", "to_draw2", "hit_clock", "holdable"},
        draw=draw_self,
        update=update_immune,
        hit_clock=hit_clock_beehive,
        immune=false,
        immune_until=0,
        i=i,
        j=j
    }

    make_immune(t, OBJ_IMMUNE_DUR)

    register_grid_object(t, c.i, c.j)
end

function hit_clock_beehive(o, c)
    if (o.immune) then
        -- noop
    else
        make_immune(o, OBJ_IMMUNE_DUR)
        cloud_particles(o.x, o.y-1, 0.5, {3,4}, 8, {7})

        create_bee(o.x + 8, o.y)

        --deregister_grid_object(o)
    end
end