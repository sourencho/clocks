
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
    }

    register_object(p)
end

function update_player(p)
    update_animt(p)
    local movx,movy=0,0

    -- input
    if btn(0) then movx-=p.acc p.faceleft=true end
    if btn(1) then movx+=p.acc p.faceleft=false end
    if btn(2) then movy-=p.acc end
    if btn(3) then movy+=p.acc end

    if btnp(5) and can_input(p) then
        player_main_action(p)
    end

    if btnp(4) and can_input(p) then
        movx *= 3
        movy *= 3

        make_immune(p, 0.5)
        p.dashing = true
        p.dashing_until = time() + 0.5
        --create_tree(p.x + tern(p.faceleft, -8, 8), p.y-1)
        --SHOW_DEBUG_OBJ = not SHOW_DEBUG_OBJ
    end

    -- move
    update_movement(p,movx,movy,true,true)

    -- state
    local newstate
    if p.dashing then
        newstate = "dash"
    elseif abs(p.vx)>0.1 or abs(p.vy)>0.1 then
        newstate = "run"
    else
        newstate = "idle"
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

    -- self
    draw_self(p)

    -- draw holding
    local h = p.holding
    if h != nil then 
        h.x = p.x
        h.y = p.y - p.h - h.h/2
        p.holding:draw(p)
    end

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
    end
end

function player_main_action(p)
    if p.holding != nil then
        throw_holding(p)
    else
        -- pick up
        for i in group("holdable") do
            if v_dist(p,i) < 10 then
                p.holding = i
                deregister_grid_object(i)
                goto _
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