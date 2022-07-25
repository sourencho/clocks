-- MOVEMENT

function update_movement(s, nx, ny, bounce, collide)
    s.vx*=s.decx
    s.vy*=s.decy
 
    s.vx+=nx
    s.vy+=ny

    s.vx=mid(s.vx,-s.spdcap,s.spdcap)
    s.vy=mid(s.vy,-s.spdcap,s.spdcap)

    if collide then
        local ox,oy=s.x,s.y
      
        s.x+=s.vx
        local col_st=collide_objgroup(s,"static")
        if col_st then
            s.x=ox
            if bounce then
                s.vx*=-0.8
            else
                s.vx*=0.1
            end
        end 
        
        s.y+=s.vy
        local col_st=collide_objgroup(s,"static")
        if col_st then
            s.y=oy 
            if bounce then
                s.vy*=-0.8
            else
                s.vy*=0.2
            end
        end
    else
      s.x+=s.vx
      s.y+=s.vy
    end
end

-- PHYSICS

function bounce_off(s, norm)
    v_vel = {x = s.vx, y = s.vy}
    v_dir = v_normalize(v_vel)
    refl_dir = v_reflect(v_dir, norm)
    s.vx = refl_dir.x * v_mag(v_vel) + BOUNCE_F
    s.vy = refl_dir.y * v_mag(v_vel) + BOUNCE_F
end

function apply_force(s, dir, mag)
    s.vx = dir.x * mag
    s.vy = dir.y * mag
end

-- COLLISION

function collide_objgroup(obj,groupname)
    for obj2 in group(groupname) do
        if obj2~=obj and collide_objobj(obj,obj2) then
            return obj2
        end
    end

    return false
end

function collide_objobj(obj1,obj2)
    return (abs(obj1.x-obj2.x)<(obj1.w+obj2.w)/2 and 
            abs(obj1.y-obj2.y)<(obj1.h+obj2.h)/2)
end

function all_collide_objgroup(obj,groupname,coll_func)
    local list={}
    for obj2 in group(groupname) do
        if obj2~=obj and coll_func(obj,obj2) then
            add(list,obj2)
        end
    end
    return list
end

function line_collide_objobj(obj1,obj2)
    return aabb_line_intersect(obj2, obj1.get_line())
end

function draw_debug_coll(o)
    if SHOW_DEBUG_OBJ then
        local c = 8
        if o.name == "player" then
            c = 9
        elseif o.name == "wall" then 
            c = 12 
        end
        rect(o.x-o.w/2,o.y-o.h/2,o.x+o.w/2,o.y+o.h/2, c)
        line(o.x-1,o.y,o.x+1,o.y, 11)
        line(o.x,o.y-1,o.x,o.y+1, 11)
        --print(o.x.." "..o.y, o.x+3, o.y, 9)
    end
end

function radius_objgroup(obj,groupname,radius)
    local list = {}
    for obj2 in group(groupname) do
        local d = v_dist(obj,obj2)
        if d <= radius then
            add(list, {obj2,d})
        end
    end
    list = table_sort(list, function (x,y) return x[2] > y[2] end)
    local out = {}
    for x in all(list) do
        add(out, x[1])
    end
    return out
end