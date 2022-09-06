function create_wall(x,y,w,h,clr,clr_fill)
    local w = {
        x=x,
        y=y,
        w=w,
        h=h,
        clr=clr,
        clr_fill=clr_fill,
        name="wall",
        draw=tern(clr == nil, draw_noop, draw_rect),
        regs={"to_draw4","collides"},
    }

    register_object(w)
end