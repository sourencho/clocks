states_flower = {"sprout", "bloom"}

function create_flower(x, y)
    local c = get_cell(x, y)
    if (is_cell_invalid(c)) then
        draw_over_obj_cors[cocreate(draw_square_cor)] = {x=c.j*8,y=c.i*8,s=7,c=8}
        return
    end

    local t = {
        x=c.x,
        y=c.y,
        w=6,
        h=6,
        animt=0,
        name="flower",
        state=states_flower[1],
        state_index = 1,
        regs={"to_update","to_draw2",
              "hit_clock", "holdable", "hit_portal"},
        update=update_flower,
        draw=draw_self,
        hit_clock=hit_clock_flower,
        immune=false,
        immune_until=0,
        i=i,
        j=j
    }

    make_immune(t, OBJ_IMMUNE_DUR)

    register_grid_object(t, c.i, c.j)
end

function update_flower(t)
    update_animt(t)
    update_immune(t)
end

function hit_clock_flower(t, c)
    if t.immune then 
        -- noop
    else
        make_immune(t, OBJ_IMMUNE_DUR)

        cloud_particles(t.x, t.y-1, 0.5, {3,4}, 8, {7})
        t.state_index += 1
        if (t.state_index > #states_flower) then
            deregister_grid_object(t)
        else
            t.state = states_flower[t.state_index]
        end
    end
end