spawner = {
    spawntime = 4,
}

function update_spawner()
    if (spawner.spawntime < time()) then
        local c = get_rnd_valid_grid_cell()
        create_tree(c.x, c.y) 
        spawner.spawntime += 5 + rnd(1)
    end
end