function _init()
    cls()
    game_state = "change_level"
    drk=parse"0=0,0,1,1,2,1,5,13,2,4,9,3,1,1,2,4"
    shkx, shky, camx, camy, xmod, ymod = 0,0,0,0,0,0
    floatxts={}
    draw_under_obj_cors = {}
    draw_over_obj_cors = {}
    --mouse.init()
end

function _update()

    if game_state == "change_level" then
        game_state = "load_level"
        draw_under_obj_cors[cocreate(draw_load_level_cor)] = curr_level
        clear_objects()
        spawn_objects()
        return
    end

    if game_state == "load_level" then
        return
    end

    update_text()
    update_shake()
    update_objects()
    update_spawner()

    menuitem(
        1, 
        "debug_grid",
        function() SHOW_DEBUG_GRID = not SHOW_DEBUG_GRID end
    )
    menuitem(
        2, 
        "debug_obj",
        function() SHOW_DEBUG_OBJ = not SHOW_DEBUG_OBJ end
    )
    menuitem(
        3, 
        "restart level",
        function() game_state = "change_level" end
    )
    menuitem(
        4,
        "skip level",
        function() curr_level += 1; game_state = "change_level"end
    )
    --update_mouse(mouse)
end

function _draw()
    xmod,ymod=flr(camx+shkx),flr(camy+shky)

    cls()

    draw_background()
    update_cors(draw_under_obj_cors)

    if (game_state != "gameplay") then
        return
    end

    draw_objects()
    update_cors(draw_over_obj_cors)
    draw_texts()

    if SHOW_DEBUG_GRID then
        draw_grid_debug()
    end

    camera(xmod,ymod)

    --draw_mouse(mouse)
end

function spawn_objects()
    player = create_player(24,24)
    clock = create_clock(64,64,44,CLOCK_SPEED)
    init_grid(
        GRID_START_X, GRID_START_Y,
        GRID_WIDTH, GRID_HEIGHT,
        clock
    )
    create_portal(107,110)
    --spawn_map_sprites()
    --create_season(64+8+8, 32+8)
    --create_tree(64-16,32+16)
    --create_season(110, 108)
end

function clear_objects()
    for key, reg in pairs(objs) do
        for obj in all(reg) do
            deregister_object(obj)
        end
    end
end

function draw_background()
    b1_clr = tern(get_form(player) == "_baby", 12, 1)
    b2_clr = tern(get_form(player) == "_baby", 1, 0)

    if get_form(player) == "_dead" then
        b1_clr = 0
    end

    -- Pattern made using https://seansleblanc.itch.io/pico-8-fillp-tool
    rectfill(-20,-20,148,148,b1_clr)
    fillp(0B1000010100100000.1)
    rectfill(-20,-20,148,148,b2_clr)
    fillp()
end

function draw_texts()
    for txt in all(floatxts) do
        local c1,c2=txt.c1,txt.c2
        if txt.t>1.8 then c1,c2=drk[c1],drk[c2] end
        draw_text(txt.str,txt.x,txt.y,1,c1,c2)
    end
end