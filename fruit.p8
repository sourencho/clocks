function create_fruit(x, y)
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
    }

    make_immune(t, 1)

    register_object(t)
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
        add_shake(1)
        cloud_particles(o.x, o.y-1, 0.5, {3,4}, 8, {7})

        deregister_object(o)
    end
end

function hit_player_fruit(o, p)
    p.score += 1
    deregister_object(o)
end