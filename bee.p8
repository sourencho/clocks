function create_bee(x, y)
    local c = get_cell(x, y)
    if (is_cell_occupied(c)) then
        draw_over_obj_cors[cocreate(draw_square_cor)] = {x=j*8,y=i*8,s=7,c=8}
        return
    end

    local t = {
        x=x,
        y=y,
        w=4,
        h=4,
        vx=0,
        vy=0,
        acc=0.3,
        spdcap=2,
        decx=0.6,
        decy=0.6,
        animt=0,
        name="bee",
        regs={"to_update", "to_draw4", "hit_clock"},
        faceleft=true,
        update=update_bee,
        draw=draw_self,
        hit_clock=hit_clock_bee,
        immune=false,
        immune_until=0,
        i=i,
        j=j
    }

    make_immune(t, OBJ_IMMUNE_DUR)

    register_object(t)
end

function update_bee(o)
    local targets = table_filter(
        group_table("bee_target"),
        function (x) return x.name != "flower" or (x.state == "bloom") end
    )

    local target = table_best(
        targets,
        function (x,y) return v_dist_sqr(x,o) < v_dist_sqr(y,o) end
    )

    local movx,movy=0,0
    local dist = v_dist_sqr(target, o)
    local dir = v_normalize(v_subv(target, o))
    movx += dir.x * o.acc
    movy += dir.y * o.acc
    o.faceleft = dir.x < 0

    if (dist > 4) then
        update_movement(o,movx,movy,true,true)
    end

    update_animt(o)
    update_immune(o)

    local hits=all_collide_objgroup(o,"hit_bee",collide_objobj)
    for h in all(hits) do
        h:hit_bee(o)
    end

end

function hit_clock_bee(o, c)
    if (o.immune) then
        -- noop
    else
        make_immune(o, OBJ_IMMUNE_DUR)
        cloud_particles(o.x, o.y-1, 0.5, {3,4}, 8, {7})

        deregister_object(o)
    end
end