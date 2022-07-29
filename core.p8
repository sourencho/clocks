function _init()
    cls()
    drk=parse"0=0,0,1,1,2,1,5,13,2,4,9,3,1,1,2,4"
    shkx, shky, camx, camy, xmod, ymod = 0,0,0,0,0,0
    floatxts={}
    init_anim_info()
    init_grid(GRID_START_X, GRID_START_Y, GRID_WIDTH, GRID_HEIGHT)
    spawn_objects()

    --mouse.init()
end

function _update()
    update_text()
    update_shake()
    update_objects()
    update_spawner()

    --update_mouse(mouse)
end

function _draw()
    xmod,ymod=flr(camx+shkx),flr(camy+shky)

    cls()

    draw_background()
    draw_objects()
    update_cors(draw_cors)
    draw_texts()

    if SHOW_DEBUG_GRID then
        draw_grid_debug()
    end

    camera(xmod,ymod)

    --draw_mouse(mouse)
end

function spawn_objects()
    create_clock(64,64,44,4)
    create_player(80,80)
    create_season(64, 40)
    --create_season(40, 80)
end

function draw_background()
    -- Pattern made using https://seansleblanc.itch.io/pico-8-fillp-tool
    rectfill(-20,-20,148,148,1)
    fillp(0B1000010100100000.1)
    rectfill(-20,-20,148,148,0)
    fillp()
end

function draw_texts()
    for txt in all(floatxts) do
        local c1,c2=txt.c1,txt.c2
        if txt.t>1.8 then c1,c2=drk[c1],drk[c2] end
        draw_text(txt.str,txt.x,txt.y,1,c1,c2)
    end
end