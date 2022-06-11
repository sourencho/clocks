clock = nil

function _init()
    clock = create_clock(64,64,34,12)
end

function _update()
    clock_update(clock)
end

function _draw()
    cls()
    map(0, 0, 0, 0, 16, 16)
    clock_draw(clock)
end
