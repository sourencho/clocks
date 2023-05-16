function create_player(x, y)
    p = {
        x=x,
        y=y,
        vx=0,
        vy=0,
        acc=1.1,
        spdcap=1000,
        decx=0.6,
        decy=0.6,
        w=6,
        h=6,
        animt=0,
        faceleft=true,
        name="player",
        state="idle_adult",
        regs={
            "to_update","to_draw3", "player", 
            "hit_clock", "collides", "bee_target"},
        update=update_player,
        draw=draw_player,
        hit_clock=hit_clock_player,
        immune=false,
        immune_until=0,
        whiteframe=0,
        flash_clr=1,
        holding=nil,
        dashing=false,
        dashing_until=0,
        forms={"_baby", "_kid", "_adult", "_dead"},
        form_index=2
    }

    register_object(p)

    return p
end

function update_player(p)
    update_animt(p)

    if p.state == "idle_dead" then
        return
    end

    local movx,movy=0,0
    local dir = {x=0,y=0}

    -- input
    if btn(0) then dir.x=-1 p.faceleft=true end
    if btn(1) then dir.x=1 p.faceleft=false end
    if btn(2) then dir.y=-1 end
    if btn(3) then dir.y=1 end

    if (dir.x != 0 or dir.y != 0) then
        dir = v_normalize(dir)
    end

    if can_input(p) then
        if btnp(5) then
            player_main_action(p)
        end

        --[[
        if btnp(4) then
            if (dir.x != 0 or dir.y != 0) then
                movx = dir.x * p.acc * 4
                movy = dir.y * p.acc * 4
            else
                movx = tern(p.faceleft, -1, 1) * p.acc * 8
            end

            make_immune(p, 0.5)
            p.dashing = true
            p.dashing_until = time() + 0.5
            --create_tree(p.x + tern(p.faceleft, -8, 8), p.y-1)
            --SHOW_DEBUG_OBJ = not SHOW_DEBUG_OBJ
       end
       --]]

        movx += dir.x * p.acc
        movy += dir.y * p.acc

    end

    -- move
    update_movement(p,movx,movy,true,true)

    -- state
    local newstate
    local form = get_form(p)

    if can_input(p) then
        if p.dashing then
            newstate = "dash"..form
        elseif abs(p.vx)>0.1 or abs(p.vy)>0.1 then
            newstate = "run"..form
        else
            newstate = "idle"..form
        end

        if newstate ~= p.state then
            p.state, p.animt = newstate, 0
        end
    end

    -- collision
    local hits=all_collide_objgroup(p,"hit_player",collide_objobj) 
    for h in all(hits) do
        h:hit_player(p)
    end

    -- immunitiy
    p.immune = time() < p.immune_until

    -- dashing
    p.dashing = time() < p.dashing_until
end

function can_input(p)
    return p.state != "idle_baby" and p.state != "idle_dead"
end

function draw_player(p)
    -- shadow
    line(p.x-2, p.y+2, p.x+1, p.y+2, 0)
    line(p.x-3, p.y+3, p.x+2, p.y+3, 0)
    line(p.x-2, p.y+4, p.x+1, p.y+4, 0)

    -- self
    draw_self(p)

    if p.state == "idle_dead" or p.state == "idle_baby" then
        return
    end

    -- draw holding
    local h = p.holding
    if h != nil then 
        h.x = p.x
        h.y = p.y - p.h - h.h/2
        p.holding:draw(p)
    end

    local c = target_cell(p)

    if is_cell_invalid(c) or not can_hold(p) then
        draw_target(c.x-4, c.y-5, 8)
    elseif c.obj != nil then
        if contains(c.obj.regs, "holdable") then
            draw_target(c.x-4, c.y-5, tern(h == nil, 7, 12))
            if c.obj.draw_hover != nil then
                c.obj:draw_hover()
            end
        elseif c.obj.name == "portal"  then
            draw_target(c.x-4, c.y-5, tern(p.holding == nil, 5,9))
        else
            draw_target(c.x-4, c.y-5, 5)
        end
    else
        draw_target(c.x-4, c.y-5, 6)
    end

end

function hit_clock_player(p, c, inFront)
    if (p.immune) then 
    else
        make_immune(p, 1)
        add_shake(4)
        cloud_particles(p.x, p.y, 0.5, {3,4}, 8, {9,10})

        if p.holding != nil then
            p.holding = nil
        end

        new_index = p.form_index + tern(inFront, 1, -1)
        if new_index == 0 then
            printh("Game Over")
        elseif new_index > #p.forms then
            assert("Form out of bounds")
        else
            p.form_index = new_index;
            p.state, p.animt = "idle"..get_form(p), 0
        end
    end
end

function player_main_action(p)
    if p.holding != nil then
        place_holding(p)
    else
        if (can_hold(p)) then
            local c = target_cell(p)
            if c.obj != nil and contains(c.obj.regs, "holdable") then
                pick_up(p,c.obj)
            end
        end
    end
end 

function place_holding(p)
    local c = target_cell(p)
    if not is_cell_invalid(c) then
        holding_o = p.holding
        if c.obj != nil then 
            if c.obj.submittable then
                -- submit
                submit_object(c.obj, p.holding)
                p.holding = nil
            elseif contains(c.obj.regs, "holdable") then
                -- swap
                pick_up(p, c.obj)
                register_object_at_cell(holding_o, c)
            end
        else
            -- drop
            p.holding = nil
            register_object_at_cell(holding_o, c)
        end
    end
end

function pick_up(p, o)
    p.holding = o
    deregister_grid_object(o)
end

function target_cell(p)
    return get_cell(p.x + tern(p.faceleft, -6, 6), p.y)
end

function get_form(p)
    return p.forms[p.form_index]
end

function can_hold(p)
    return true
    -- return get_form(p) == "_adult"
end