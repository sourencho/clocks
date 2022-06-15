states_tree = {"sapling", "bush", "tree", "tree_fruit", "tree_dry"}

function create_tree(x, y)
    local t = {
        x=x,
        y=y,
        vx=0,
        vy=0,
        acc=1.1,
        spdcap=2,
        decx=0.6,
        decy=0.6,
        w=6,
        h=6,
        animt=0,
        faceleft=true,
        name="tree",
        state=states_tree[1],
        state_index = 1,
        regs={"to_update","to_draw2", "hit_clock"},
        update=update_tree,
        draw=draw_self,
        hit_clock=hit_clock_tree,
        immune=false,
        immune_until=0,
    }

    make_immune(t, 1)

    register_object(t)
end

function update_tree(t)
    update_animt(t)

    -- immunitiy
    t.immune = time() < t.immune_until
end

function hit_clock_tree(t, c)
    if (t.immune) then 
        -- noop
    else
        make_immune(t, 0.2)
        add_shake(1)

        t.state_index += 1
        if (t.state_index > #states_tree) then
            --deregister_object(t)
        else
            t.state = states_tree[t.state_index] 
            if (t.state == "tree_fruit") then
                create_fruit(t.x - 8, t.y)
                create_fruit(t.x + 8, t.y)
            end
        end
    end
end

function make_immune(o, dur)
    o.immune = true
    o.immune_until = time() + dur
    o.whiteframe = dur * 30
end