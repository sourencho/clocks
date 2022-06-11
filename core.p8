clock = nil

function _init()
    cls()
    init_anim_info()
    clock = create_clock(64,64,34,12)
    spawn_objects()
end

function _update()
    update_clock(clock)
    update_objects()
end

function _draw()
    cls()
    map(0, 0, 0, 0, 16, 16)
    draw_clock(clock)
    draw_objects()
end

function spawn_objects()
    create_player(80,80)
end