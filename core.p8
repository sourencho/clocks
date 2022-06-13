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
    map(0, 0, 0, 0, 16, 16)
    draw_objects()

    camera(xmod,ymod)
end

function spawn_objects()
    create_clock(64,64,44,12)
    create_player(80,80)
end