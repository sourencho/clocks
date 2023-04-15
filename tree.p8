states_tree = {"bush", "tree", "tree_dry"}

function create_tree(x, y)
    local c = get_cell(x, y)
    if (is_cell_occupied(c)) then
        draw_over_obj_cors[cocreate(draw_square_cor)] = {x=c.j*8,y=c.i*8,s=7,c=8}
        return
    end

    local t = {
        x=c.x,
        y=c.y,
        w=6,
        h=6,
        animt=0,
        faceleft=true,
        name="tree",
        state=states_tree[1],
        state_index = 1,
        regs={"to_update","to_draw2", "hit_clock", "holdable"},
        update=update_tree,
        draw=draw_self,
        hit_clock=hit_clock_tree,
        hit_rain=hit_rain_tree,
        immune=false,
        immune_until=0,
        i=i,
        j=j
    }

    make_immune(t, OBJ_IMMUNE_DUR)

    register_grid_object(t, c.i, c.j)
end

function update_tree(t)
    update_animt(t)
    update_immune(t)
end

function hit_clock_tree(t, c)
    if t.immune then 
        -- noop
    else
        make_immune(t, OBJ_IMMUNE_DUR)

        cloud_particles(t.x, t.y-1, 0.5, {3,4}, 8, {7})
        t.state_index += 1
        if (t.state_index > #states_tree) then
            deregister_grid_object(t)
        else
            t.state = states_tree[t.state_index] 
        end
    end
end

function hit_rain_tree(t)
    if t.state == "tree" then
        t.state = "tree_fruit"
        create_fruit(t.x - 8, t.y, "orange")
        create_fruit(t.x + 8, t.y, "orange")
        cloud_particles(t.x, t.y-1, 0.5, {3,4}, 8, {12})
    end
end