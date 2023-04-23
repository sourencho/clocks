-- Returns true if line segments AB and CD intersect
-- Thanks ChatGPT
function intersect(A, B, C, D)
    -- Calculate the direction vectors of the line segments
    local ABx, ABy = B.x - A.x, B.y - A.y
    local CDx, CDy = D.x - C.x, D.y - C.y

    -- Calculate the denominator of the parametric equations for the lines
    local denom = ABx * CDy - ABy * CDx

    -- If the denominator is zero, the lines are parallel and never intersect
    if denom == 0 then return false end

    -- Calculate the parameters for the intersection point along both lines
    local t = (CDx * (A.y - C.y) - CDy * (A.x - C.x)) / denom
    local u = (ABx * (A.y - C.y) - ABy * (A.x - C.x)) / denom

    -- If t and u are both between 0 and 1, the line segments intersect
    return t >= 0 and t <= 1 and u >= 0 and u <= 1
end

function aabb_points(aabb)
    return {
        {x=aabb.x-aabb.w/2, y=aabb.y-aabb.h/2},
        {x=aabb.x+aabb.w/2, y=aabb.y-aabb.h/2},
        {x=aabb.x+aabb.w/2, y=aabb.y+aabb.h/2},
        {x=aabb.x-aabb.w/2, y=aabb.y+aabb.h/2},
    }
end

function aabb_line_intersect(aabb, l)
    local points = aabb_points(aabb)
    for i=1,4 do
        if intersect(points[i], points[(i % 4)+1], l[1], l[2]) then
            return true
        end
    end
end