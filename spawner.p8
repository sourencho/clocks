SPAWN_RATE = 6

spawntime = 0

-- SPAWN WEIGHTS
spawn_weights = {
    {0.4, create_tree},
    {0.2, create_season},
    {0.1, create_beehive},
    {0.3, create_flower}
}

function get_spawn_func()
    r = rnd()
    s = 0
    for item in all(spawn_weights) do
        prob, spawn_func = item[1], item[2]
        s += prob
        if r <= s then
            return spawn_func
        end
    end
end

function update_spawner()
    if (spawntime < time()) then
        local coord = get_rnd_valid_grid_cell()
        get_spawn_func()(coord.x, coord.y)
        spawntime += SPAWN_RATE
    end
end