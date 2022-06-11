function draw_anim(x, y, char, state, t, xflip, is_player)
    local sinfo = anim_info[char][state]
    local spri = sinfo.sprites[flr(t/sinfo.dt)%#sinfo.sprites+1]
    local wid = sinfo.width or 1
    local hei = sinfo.height or 1
    local xflip = xflip or false
    spr(spri,x-wid*4+tern(xflip and is_player,1,0),y-hei*4,wid,hei,xflip)
end

function anim_step(o)
    local state=o.state
    local info=anim_info[o.name][state]

    local v=flr(o.animt/info.dt%#info.sprites)

    return v,(o.animt%info.dt<0.01)
end


function draw_self(s)
    local foo=function(s)
               local state=s.state or "only"
               local z=s.z or 0
               draw_anim(s.x, s.y-1, s.name, state, s.animt, s.faceleft)
              end

    foo(s)
    --[[
    local c
    if s.whiteframe then c=7 end
    draw_outline(foo,c,s)
    if s.whiteframe then all_colors_to(7) end
    foo(s)
    if s.whiteframe then all_colors_to() s.whiteframe=false end
    --]]
end
