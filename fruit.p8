function create_fruit(x, y, type)
    local c = get_cell(x, y)
    if (is_cell_occupied(c)) then
        draw_over_obj_cors[cocreate(draw_square_cor)] = {x=j*8,y=i*8,s=7,c=8}
        return
    end

    local t = {
        x=x,
        y=y,
        vx=0,
        vy=0,
        acc=1.1,
        spdcap=2,
        decx=0.6,
        decy=0.6,
        w=4,
        h=4,
        animt=0,
        faceleft=true,
        name="fruit",
        state=type,
        regs={"to_update","to_draw2", "hit_clock", "holdable"},
        update=update_fruit,
        draw=draw_self,
        hit_clock=hit_clock_fruit,
        immune=false,
        immune_until=0,
        i=i,
        j=j
    }

    make_immune(t, OBJ_IMMUNE_DUR)

    register_grid_object(t, c.i, c.j)
end

function update_fruit(t)
    update_animt(t)

    -- immunitiy
    t.immune = time() < t.immune_until
end

function hit_clock_fruit(o, c)
    if (not o.immune) then
        cloud_particles(o.x, o.y-1, 0.5, {3,4}, 8, {7})
        deregister_grid_object(o)
    end
end