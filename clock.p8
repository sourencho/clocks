function create_clock(x,y,r,spd)
    c = {
        x=x,
        y=y,
        xe=x,
        ye=y,
        r=r,
        a=0,
        spd=spd, --speed
        name="clock",
        regs={"to_update","to_draw2"},
        draw=draw_clock,
        update=update_clock,
        get_line=get_line,
        draw_debug=draw_debug
    }

    create_wall(11,64,7,112,nil)
    create_wall(128-10,64,7,112,nil)
    create_wall(64,11,112,7,nil)
    create_wall(64,128-9,112,7,nil)
    create_wall(64,65,8,7,nil)

    register_object(c)
end

function update_clock(c)
    -- update movement
    c.a = -t()/c.spd % 1.0
    c.xe = c.r*cos(c.a) + c.x;
    c.ye = c.r*sin(c.a) + c.y;
 
    -- collision
    local hits=all_collide_objgroup(c,"hit_clock",line_collide_objobj) 
    for h in all(hits) do
        h:hit_clock(c)
    end
end

function draw_clock(c)
    -- draw base
    rectfill(12,12,118,118,1)
    map(0 , 0, 0, 0, 16, 16)

    -- draw hand
    linefill(c.x, c.y+1, c.xe, c.ye+1, 1.6, 4)
    linefill(c.x, c.y, c.xe, c.ye, 1.6, 9)

    -- draw center
    circfill(64,65,3,6)
    circfill(64,64,3,7)
end

function get_line(c)
    return {{x=c.x, y=c.y}, {x=c.xe, y=c.ye}}
end

function draw_debug()
    line(c.x, c.y, c.xe, c.ye, 8)
end