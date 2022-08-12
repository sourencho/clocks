
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
        state="idle",
        regs={"to_update","to_draw3", "player", "hit_clock"},
        update=update_player,
        draw=draw_player,
        hit_clock=hit_clock_player,
        immune=false,
        immune_until=0,
        whiteframe=0,
        flash_clr=1,
        score=0,
        holding=nil,
        dashing=false,
        dashing_until=0,
        forms={"_adult", "_baby"},
        form_index=1
    }

    register_object(p)

    return p
end

function update_player(p)
    update_animt(p)
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
    end

    movx += dir.x * p.acc
    movy += dir.y * p.acc

    -- move
    update_movement(p,movx,movy,true,true)

    -- state
    local newstate
    local form = get_form(p)
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
    return p.dashing == false
end

function draw_player(p)
    -- shadow
    line(p.x-2, p.y+2, p.x+1, p.y+2, 0)
    line(p.x-3, p.y+3, p.x+2, p.y+3, 0)
    line(p.x-2, p.y+4, p.x+1, p.y+4, 0)

    -- draw holding
    local h = p.holding
    if h != nil then 
        h.x = p.x
        h.y = p.y - p.h - h.h/2
        p.holding:draw(p)
    else
        -- draw target
        for i in group("holdable") do
            if v_dist(p,i) < 10 then
                spr(tern(can_hold(p), 3, 19), i.x-4, i.y-5)
                goto __
            end
        end
        ::__::
    end

    -- self
    draw_self(p)

    -- UI
    print(p.score, 2, 2, 6)
end

function hit_clock_player(p, c)
    if (p.immune) then 
    else
        make_immune(p, 1)
        add_shake(4)
        cloud_particles(p.x, p.y, 0.5, {3,4}, 8, {9,10})

        if p.holding != nil then
            throw_holding(p)
        end

        p.form_index = (p.form_index % #p.forms) + 1
    end
end

function player_main_action(p)
    if p.holding != nil then
        throw_holding(p)
    else
        -- pick up
        if (can_hold(p)) then
            for i in group("holdable") do
                if v_dist(p,i) < 10 then
                    p.holding = i
                    deregister_grid_object(i)
                    goto _
                end
            end
        end

        ::_::
    end
end

function throw_holding(p)
    p.holding.vx = 5*tern(p.faceleft, -1, 1)
    --p.holding.vy = 30*-.8
    make_airborn(p.holding, 0)
    register_object(p.holding)
    p.holding=nil
end

function get_form(p)
    return p.forms[p.form_index]
end

function can_hold(p)
    return get_form(p) == "_adult"
end