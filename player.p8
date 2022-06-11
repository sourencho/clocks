
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
        regs={"to_update","to_draw3", "player"},
        draw=draw_player,
        update=update_player
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
end

function draw_player(p)
    -- shadow
    line(p.x-2, p.y+2, p.x+1, p.y+2, 0)
    line(p.x-3, p.y+3, p.x+2, p.y+3, 0)
    line(p.x-2, p.y+4, p.x+1, p.y+4, 0)

    draw_self(p)
end