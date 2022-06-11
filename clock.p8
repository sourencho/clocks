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
    return c
end

function clock_update(c)
    c.a = -t()/c.s % 1.0

    c.xe = c.r*cos(c.a) + c.x;
    c.ye = c.r*sin(c.a) + c.y;
end

function clock_draw(c)
    -- draw base
    rectfill(12,12,118,118,1)
    map(0, 0, 0, 0, 16, 16)

    -- draw hand
    line(c.x, c.y, c.xe, c.ye, 9)

    -- draw center
    circfill(64,65,3,6)
    circfill(64,64,3,7)

end