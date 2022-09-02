curr_level = 2
level_size = 16

-- ACTORS
level_actor_creator = {
    [55]=create_season,
    [39]=create_tree,
    [36]=create_portal
}

function spawn_map_sprites()
    for s in all(get_sprites(curr_level)) do
        if (level_actor_creator[s.spr_n] ~= nil) then
            level_actor_creator[s.spr_n](s.x*8+4,s.y*8+4)
        end
    end
end

function get_sprites(l)
    local sprites = {}
    for i=0,level_size-1 do
        for j=0,level_size-1 do
            add(sprites, {spr_n=get_tile(i,j,l), x=i,y=j})
        end
    end
    return sprites
end

function get_tile(x,y,l)
    i = (x + l*level_size) % 128
    j = y + flr(level_size * l / 128)*level_size
    return mget(i,j)
end

function draw_load_level_cor(l)
    local text = "level "..l
    for i=0,30 do
        print(text, hcenter(text), vcenter(text), 10)
        yield()
    end
    game_state = "gameplay"
end