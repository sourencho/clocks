function draw_noop(o)
    draw_debug_coll(o)
end

function draw_line(a,b,clr)
    line(a.x, a.y, b.x, b.y, clr)
end

function draw_rect(o)
    local x1,y1,x2,y2=o.x-o.w/2,o.y-o.h/2,o.x+o.w/2,o.y+o.h/2
    rect(x1,y1,x2,y2,o.clr)
    if o.clr_fill then
        rectfill(x1+1,y1+1,x2-1,y2-1,o.clr_fill)
    end
    draw_debug_coll(o)
end

function draw_circ_cor(data)
    for i=0,10 do
        circ(data.x, data.y, data.r, data.c)
        yield()
    end
end

function draw_square_cor(data)
    for i=0,10 do
        if (i % 4 == 0) then 
            rect(data.x, data.y, data.x+data.s, data.y+data.s, data.c)
        end
        yield()
    end
end

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
    -- sprite
    local foo=function(s)
               local state=s.state or "only"
               local z=s.z or 0
               draw_anim(s.x, s.y-1, s.name, state, s.animt, s.faceleft)
              end

    -- foo + whiteframe
    if (s.whiteframe != nil and s.whiteframe > 0 and t() % 0.1 < 0.01) then
        all_colors_to(s.flash_clr or 6)
    end

    foo(s)

    all_colors_to()
    if (s.whiteframe != nil and t()) then
        s.whiteframe = max(s.whiteframe-1, 0)
    end

    -- debug
    draw_debug_coll(s)
end

function add_shake(p)
    local a=rnd(1)
    shkx+=p*cos(a)
    shky+=p*sin(a)
end

function update_shake()
    if abs(shkx)+abs(shky)<0.5 then
        shkx,shky=0,0
    else
        shkx*=-0.5-rnd(0.2)
        shky*=-0.5-rnd(0.2)
    end
end
