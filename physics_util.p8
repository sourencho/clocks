function ccw(A,B,C)
    return (C.y-A.y) * (B.x-A.x) > (B.y-A.y) * (C.x-A.x)
end

-- Return true if line segments AB and CD intersect
function intersect(A,B,C,D)
    return ccw(A,C,D) != ccw(B,C,D) and ccw(A,B,C) != ccw(A,B,D)
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