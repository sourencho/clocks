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

-- c is a grid cell
function draw_grid_rain_cor(c)
    local start_x=c.x + tern(rnd()>0.5, -8, 8)
    local start_y=-4
    local end_x=c.x
    local end_y=c.y
    local n = (end_y - start_y)/8
    local x, y
    for i=0,n do
        x = lerp(start_x, end_x, i/n)
        y = lerp(start_y, end_y, i/n)
        line(x, y, x, y+1, 12)
        yield()
    end
    for r=2,4 do
        circ(x, y, r/2, 12)
        yield()
    end
    if (c.obj != nil and c.obj.hit_rain != nil) then
        c.obj:hit_rain()
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

function update_animation_obj(o)
    update_animt(o)
end

function draw_self(s)
    -- sprite
    local foo=function(s)
               local state=s.state or "idle"
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

function draw_target(x, y, clr)
    pal(7,clr)
    spr(3, x, y)
    pal()
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

function hcenter(s)
  return 64-#s*2
end

function vcenter(s)
  return 61
end

function thick_print(s, x, y, c1, c2)
    print(s, x, y+1, c2)
    print(s, x, y, c1)
end