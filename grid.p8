function init_grid(start_x, start_y, width, height)
    grid = {}
    for i=0,15 do
        grid[i] = {}
        for j=0,15 do
            local e = {
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
end

function add_grid(i, j, o)
    local cell = grid[i][j]
    if (not cell.valid or cell.obj ~= nil) then
        return false, nil, nil
    end

    cell.obj = o
    return true, cell.x, cell.y
end

function add_grid_xy(x, y, o)
    j,i = get_grid_coord(x,y)
    valid, x, y = add_grid(i, j, t)
    return valid, x, y, i, j
end

function deregister_grid_object(o)
    grid[o.i][o.j].obj = nil
    deregister_object(o)
end