function create_fruit(x, y)

    local c = get_cell(x, y)
    if (is_cell_invalid(c)) then
        draw_cors[cocreate(draw_square_cor)] = {x=j*8,y=i*8,s=7,c=8}
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
        state="idle",
        regs={"to_update","to_draw2", "hit_clock", "hit_player"},
        update=update_fruit,
        draw=draw_self,
        hit_clock=hit_clock_fruit,
        hit_player=hit_player_fruit,
        immune=false,
        immune_until=0,
        i=i,
        j=j
    }

    make_immune(t, 1)

    register_grid_object(t, c.i, c.j)
end

function update_fruit(t)
    update_animt(t)

    -- immunitiy
    t.immune = time() < t.immune_until
end

function hit_clock_fruit(o, c)
    if (o.immune) then 
        -- noop
    else
        make_immune(o, 0.2)
        add_shake(0.3)
        cloud_particles(o.x, o.y-1, 0.5, {3,4}, 8, {7})

        deregister_grid_object(o)
    end
end

function hit_player_fruit(o, p)
    p.score += 1
    create_text(p.x, p.y, "+1", 7, 0)
    deregister_grid_object(o)
end