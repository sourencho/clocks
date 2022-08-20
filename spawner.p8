SPAWN_RATE = 5

spawner = {
    spawntime = 0,
}

function update_spawner()
    if (spawner.spawntime < time()) then
        --local c = get_rnd_valid_grid_cell()
        local c = grid[13][2]
        create_tree(c.x, c.y) 
        spawner.spawntime += SPAWN_RATE
    end
end