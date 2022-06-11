function create_clock(x,y,r,n)
    c = {
        x=x,
        y=y,
        xe=x,
        ye=y,
        r=r,
        a=0,
        n=n
    }
    return c
end

function clock_update(c)
    --[[
    if t() % 0.8 < 0.01 then
        c.a -= 1./c.n

        c.xe = c.r*cos(c.a) + c.x;
        c.ye = c.r*sin(c.a) + c.y;
    end

    clock_collision(c)
    --]]
end

function clock_draw(c)
    --[[
    ngon(64, 64, c.r, c.n, 12)  -- a blue octagon
    circfill(64,64,2,9)
    line(c.x, c.y, c.xe, c.ye, 9)

    local clr = 7
    local ls = {x=50, y=50}
    local le = {x=45, y=20}
    if (intersect({x=c.x, y=c.y}, {x=c.xe, y=c.ye}, ls, le)) clr = 8
    line(ls.x, ls.y, le.x, le.y, clr)
    --]]

    -- draw base
    rectfill(12,12,118,118,1)
    map(0, 0, 0, 0, 16, 16)

    -- draw center
    circfill(64,65,3,6)
    circfill(64,64,3,7)

    -- draw hands
    line()
end

function draw_base()
end

function clock_collision(c)
    for i=BOARD_Y_START,BOARD_Y_END do
        for j=BOARD_X_START,BOARD_X_END do
            local e = board[i][j]
            if aabb_line_intersect(e, {{x=c.x, y=c.y}, {x=c.xe, y=c.ye}}) then
                rectfill(e.x, e.y, e.x+e.w, e.y+e.h, 8)
            end
        end
    end
end

