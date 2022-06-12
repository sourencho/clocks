function create_clock(x,y,r,s)
    c = {
        x=x,
        y=y,
        xe=x,
        ye=y,
        r=r,
        a=0,
        s=s --speed
    }

    create_wall(11,64,7,112,nil)
    create_wall(128-10,64,7,112,nil)
    create_wall(64,11,112,7,nil)
    create_wall(64,128-9,112,7,nil)
    create_wall(64,65,8,7,nil)

    return c
end

function update_clock(c)
    c.a = -t()/c.s % 1.0

    c.xe = c.r*cos(c.a) + c.x;
    c.ye = c.r*sin(c.a) + c.y;
end

function draw_clock(c)
    -- draw base
    rectfill(12,12,118,118,1)
    map(0, 0, 0, 0, 16, 16)

    -- draw hand
    linefill(c.x, c.y, c.xe, c.ye, 1, 9)


    -- draw center
    circfill(64,65,3,6)
    circfill(64,64,3,7)

end