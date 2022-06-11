clock = nil

function _init()
    --init_board()
    clock = create_clock(64,64,40,8)
end

function _update()
    clock_update(clock)
end

function _draw()
    cls()
    --draw_board()
    map(0, 0, 0, 0, 16, 16) 
    clock_draw(clock)
end
