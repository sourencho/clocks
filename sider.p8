states_sider={"egg", "side3", "side4", "side6", "side41"}

function create_sider(x, y)

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
        name="sider",
        state=states_sider[1],
        state_index = 1,
        regs={"to_update","to_draw2", "hit_clock", "holdable"},
        update=update_sider,
        draw=draw_self,
        hit_clock=hit_clock_sider,
        hit_player=hit_player_sider,
        immune=false,
        immune_until=0,
        i=i,
        j=j
    }

    make_immune(t, OBJ_IMMUNE_DUR)

    register_grid_object(t, c.i, c.j)
end

function update_sider(t)
    update_animt(t)
    update_immune(t)
end

function hit_clock_sider(o, c)
    if o.immune then 
        -- noop
    else
        make_immune(o, OBJ_IMMUNE_DUR)

        cloud_particles(o.x, o.y-1, 0.5, {3,4}, 8, {7})
        o.state_index += 1
        if (o.state_index > #states_sider) then
            --noop
        else
            o.state = states_sider[o.state_index] 
        end
    end
end

function hit_player_sider(o, p)
    -- todo
end