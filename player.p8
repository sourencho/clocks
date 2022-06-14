
function create_player(x, y)
    p = {
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

    -- move
    update_movement(p,movx,movy,true,true)

    -- state
    local newstate
    if abs(p.vx)>0.1 or abs(p.vy)>0.1 then
        newstate = "run"
    else
        newstate = "idle"
    end

    if newstate ~= p.state then
        p.state, p.animt = newstate, 0
    end

    -- immunitiy
    p.immune = time() < p.immune_until
end

function draw_player(p)
    -- shadow
    line(p.x-2, p.y+2, p.x+1, p.y+2, 0)
    line(p.x-3, p.y+3, p.x+2, p.y+3, 0)
    line(p.x-2, p.y+4, p.x+1, p.y+4, 0)

    draw_self(p)
end

function hit_clock_player(p, c)
    if (p.immune) then 
    else
        p.immune = true
        p.immune_until = time() + 1
        p.whiteframe=1*30
        add_shake(4)
    end
end