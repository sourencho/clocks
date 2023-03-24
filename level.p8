curr_level = 1

function draw_load_level_cor(l)
    local text = "level "..l
    for i=0,30 do
        print(text, hcenter(text), vcenter(text)-2, 10)
        yield()
    end
    game_state = "gameplay"
end