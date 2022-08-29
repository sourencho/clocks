function create_portal(x, y)

    local c = get_cell(x, y)
    if (is_cell_invalid(c)) then
        draw_cors[cocreate(draw_square_cor)] = {x=j*8,y=i*8,s=7,c=8}
        return
    end

    local t = {
        x=x,
        y=y,
        vx=0,
        vy=0,
        w=4,
        h=4,
        animt=0,
        state="idle",
        name="portal",
        regs={"to_update","to_draw2"},
        draw=draw_self,
        update=update_animation_obj,
        i=i,
        j=j,
        no_grid_block=true
    }
    register_grid_object(t, c.i, c.j)
end