function _init()
    cls()
    shkx, shky, camx, camy, xmod, ymod = 0,0,0,0,0,0
    init_anim_info()
    spawn_objects()
end

function _update()
    update_shake()
    update_cors(global_cors)
    update_objects()
end

function _draw()
    xmod,ymod=flr(camx+shkx),flr(camy+shky)

    cls()

    draw_background()
    draw_objects()

    camera(xmod,ymod)
end

function spawn_objects()
    create_clock(64,64,44,3)
    create_player(80,80)
    create_tree(40, 40)
    create_season(40, 80)
end

function draw_background()
    -- Pattern made using https://seansleblanc.itch.io/pico-8-fillp-tool
    rectfill(-20,-20,148,148,1)
    fillp(0B1000010100100000.1)
    rectfill(-20,-20,148,148,0)
    fillp()
end