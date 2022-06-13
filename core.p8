function _init()
    cls()
    init_anim_info()
    spawn_objects()
end

function _update()
    update_cors(global_cors)
    update_objects()
end

function _draw()
    cls()
    map(0, 0, 0, 0, 16, 16)
    draw_objects()
end

function spawn_objects()
    create_clock(64,64,44,12)
    create_player(80,80)
end