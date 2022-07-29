mouse = {
    init = function()
        poke(0x5f2d, 1)
    end,
    -- return int:x, int:y, onscreen:bool
    pos = function()
        return {x=stat(32) - 1,y=stat(33) - 1}
    end,
    -- return int:button [0..4]
    -- 0 .. no button
    -- 1 .. left
    -- 2 .. right
    -- 4 .. middle
    button = function()
        local s = stat(34)
        return {
            lmb=s&1 > 0 and 1 or 0,
            rmb=s&2 > 0 and 2 or 0}
    end,
    clr = 6
}

function update_mouse(m)
    m.clr = 7 + m.button().lmb + m.button().rmb
end

function draw_mouse(m)
    local mouse_x, mouse_y = m.pos()
    circfill(m.pos().x,m.pos().y, 1, m.clr)
end