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
end

function is_cell_invalid(c)
    return not c.valid or c.obj ~= nil
end

function get_cell(x, y)
    j,i = get_grid_coord(x,y)
    return grid[i][j]
end

function deregister_grid_object(o)
    grid[o.i][o.j].obj = nil
    deregister_object(o)
end

function register_grid_object(o, i, j)
    grid[i][j].obj = o
    register_object(o)
end


-- todo: make this more efficient and deterministic
function get_rnd_valid_grid_cell()
    local c = {valid = false} 
    while not c.valid do
        c = grid[frnd(15)][frnd(15)]
    end
    return c
end