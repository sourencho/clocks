function create_portal(x, y)
    local c = get_cell(x, y)
    if (is_cell_invalid(c)) then
        draw_over_obj_cors[cocreate(draw_square_cor)] = {x=j*8,y=i*8,s=7,c=8}
        return
    end

    local t = {
        x=c.x,
        y=c.y,
        vx=0,
        vy=0,
        w=4,
        h=4,
        animt=0,
        state="idle",
        name="portal",
        regs={"to_update","to_draw2"},
        draw=draw_portal,
        update=update_portal,
        i=i,
        j=j,
        submittable=true,
        submitted={},
        score=0
    }
    register_grid_object(t, c.i, c.j)
end

function draw_portal(p)
    draw_self(p)

    -- local won = false

    -- goal

    -- local j = 1
    -- local won = true
    -- for g in all(level_goal[curr_level]) do
        
    --     local count = 0
    --     for s in all(p.submitted) do
    --         if (s.name == g[1] and s.state == g[2]) count += 1
    --     end

    --     spr(anim_info[g[1]][g[2]].sprites[1], 0, 8+j*10)
    --     print(count, 2, 19+j*10, 6)
    --     print(g[3], 2, 27+j*10, 5)

    --     won = won and count >= g[3]

    --     j += 3
    -- end

    -- if (won) then
    --     curr_level += 1
    --     game_state = "change_level"
    -- end

    -- UI
    print(p.score, 2, 2, 6)
end

function update_portal(p)
    update_animt(p)

    -- collision
    local hits=all_collide_objgroup(p,"holdable",collide_objobj) 
    for h in all(hits) do
        submit_object(p,h)
    end
end

function submit_object(p,o)
    local s = o
    add(p.submitted, s)
    deregister_grid_object(o)

    -- score
    s = o.name.."_"..o.state
    value = points[s] or 0
    p.score += value

    create_text(o.x,o.y,value,0,7)
end