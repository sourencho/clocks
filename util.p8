function any(xs, cond)
    for x in all(xs) do
        if cond(x) then
            return true
        end
    end
    return false
end

nums={}
for i=0,9 do nums[""..i]=true end
function parse(str,ar)
    local c,lc,ar,field=1,1,{}
    
    while c<=#str do
     local char=sub(str,c,c)
     
     if char=='{' then
      local sc,k=c+1,0
      while sub(str,c,c)~='}' or k>1 do
       char=sub(str,c,c)
       if char=='{' then k+=1
       elseif char=='}' then k-=1 end
       c+=1
      end
      local v=parse(sub(str,sc,c-1))
      if field then
       ar[field]=v
      else
       add(ar,v)
      end
      lc=c+2
      c+=1
     elseif char=='=' then
      field,lc=sub(str,lc,c-1),c+1
     elseif char==',' or c==#str then
      if c==#str then c+=1 end
      local v,vb=sub(str,lc,c-1),sub(str,lc+1,c-1)
      local fc=sub(v,1,1)
      if nums[fc] then v=v*1
      elseif fc=='%' then v=rnd(vb)
      elseif v=='true' then v=true
      elseif v=='false' then v=false
      end
      
      if field then
       if nums[sub(field,1,1)] then field=field*1 end
       ar[field]=v
      else
       add(ar,v)
      end
      
      field,lc=nil,c+1
     elseif char=='\n' then
      lc+=1
     end
     c+=1
    end
    
    return ar
end

function get_grid_coord(x,y)
    return flr(x/8),flr(y/8)
end


function table_sort(a,cmp)
    for i=1,#a do
        local j = i
            while j > 1 and cmp(a[j-1],a[j]) do
                a[j],a[j-1] = a[j-1],a[j]
                j = j - 1
        end
    end
    return a
end

function table_concat(t1, t2)
    local tc = {}
    for i=1,#t1 do
        tc[i] = t1[i]
    end
    for i=1,#t2 do
        tc[#t1+i] = t2[i]
    end
    return tc
end

function tern(cond, T, F) if cond then return T else return F end end
function pick(ar,k) k=k or #ar return ar[flr(rnd(k))+1] end
function lerp(var,target,pow) return var+pow*(target-var) end
function dist(xa,ya) return sqrt(sqrdist(xa,ya)) end
function sqrdist(x,y) return x*x+y*y end
function frnd(a) return flr(rnd(a)) end
function sqr(a) return a*a end

-- OBJECT UTIL

function make_immune(o, dur)
    o.immune = true
    o.immune_until = time() + dur
    o.whiteframe = dur * 30
end

function update_immune(o)
    o.immune = time() < o.immune_until
end

-- VECTOR UTIL 

-- Subtract v2 from v1
function v_subv( v1, v2 )
    return { x = v1.x - v2.x, y = v1.y - v2.y }
end

-- Compute magnitude of v
function v_mag( v )
    return sqrt( ( v.x * v.x ) + ( v.y * v.y ) )
end

-- Normalizes v into a unit vector
function v_normalize( v )
    local len = v_mag( v )
    return { x = v.x / len, y = v.y / len }
end