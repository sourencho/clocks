function init_grid(start_x, start_y, width, height)
    grid = {}
    for i=0,15 do
        grid[i] = {}
        for j=0,15 do
            local e = {
                i=i,
                j=j,
                x=j*8+4,
                y=i*8+4,
                obj=nil,
                valid=(
                    j >= start_x and j < start_x+width and 
                    i >= start_y and i < start_y+height
                )
            }
            grid[i][j] = e
        end
    end

    for k in all(GRID_INVALIDS) do
        grid[k[1]][k[2]].valid = false
    end
end

function draw_grid_debug()
    for i=0,15 do
        for j=0,15 do
            local e = grid[i][j]
            local c = 6
            if (e.obj != nil) c = 12
            circ(e.x, e.y, 2, e.valid and c or 8)
        end
    end

    for x=0,15 do
        local e = grid[x][0]
        print(x, e.x-2, e.y-2, 11)
        local e = grid[0][x]
        print(x, e.x-2, e.y-2, 11)
    end
end

function is_cell_invalid(c)
    return not (c.valid == true and (c.obj == nil or (c.obj ~= nil and c.obj.no_grid_block == true)))
end

function get_cell(x, y)
    j,i = get_grid_coord(x,y)
    return grid[i][j]
end

function maybe_snap_to_grid_and_register(o)
    local c = get_cell(o.x, o.y)
    if (is_cell_invalid(c)) then
        draw_cors[cocreate(draw_square_cor)] = {x=c.j*8,y=c.i*8,s=7,c=8}
        return false
    end

    o.x = c.j*8+4
    o.y = c.i*8+4
    o.i = c.i
    o.j = c.j
    register_grid_object(o,c.i,c.j)
    return true
end

function register_object_at_cell(o, c)
    o.x = c.j*8+4
    o.y = c.i*8+4
    o.i = c.i
    o.j = c.j
    register_grid_object(o, c.i, c.j)
end

function deregister_grid_object(o)
    grid[o.i][o.j].obj = nil
    deregister_object(o)
end

function register_grid_object(o, i, j)
    grid[i][j].obj = o
    register_object(o)
end

function get_cells_around(o, r)
    local cs = {}
    for i=0,15 do
        for j=0,15 do
            local c = grid[i][j]
            if v_dist_sqr(c, o) <= r*r then
                add(cs, c)
            end
        end
    end
    return cs;
end

-- todo: make this more efficient and deterministic
function get_rnd_valid_grid_cell()
    local c = {valid = false} 
    while not c.valid do
        c = grid[frnd(15)][frnd(15)]
    end
    return c
end