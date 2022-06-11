function ccw(A,B,C)
    return (C.y-A.y) * (B.x-A.x) > (B.y-A.y) * (C.x-A.x)
end

-- Return true if line segments AB and CD intersect
function intersect(A,B,C,D)
    return ccw(A,C,D) != ccw(B,C,D) and ccw(A,B,C) != ccw(A,B,D)
end

-- draw a regular n-gon using line continuation
function ngon(x, y, r, n, color)
  line(color)            -- invalidate current endpoint, set color
  for i=0,n do
    local angle = i/n
    line(x + r*cos(angle), y + r*sin(angle))
  end
end

function aabb_points(aabb)
    return {
        {x=aabb.x, y=aabb.y},
        {x=aabb.x+aabb.w, y=aabb.y},
        {x=aabb.x, y=aabb.y+aabb.h},
        {x=aabb.x+aabb.w, y=aabb.y+aabb.h},
    }
end

function aabb_line_intersect(aabb, l)
    local points = aabb_points(aabb)
    for i=1,4 do
        if intersect(points[i], points[((i+1) % 4)+1], l[1], l[2]) then 
            return true
        end
    end
end

function any(xs, cond)
    for x in all(xs) do
        if cond(x) then
            return true
        end
    end
    return false
end
