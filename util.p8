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

function tern(cond, T, F) if cond then return T else return F end end
function pick(ar,k) k=k or #ar return ar[flr(rnd(k))+1] end
function lerp(var,target,pow) return var+pow*(target-var) end
function dist(xa,ya) return sqrt(sqrdist(xa,ya)) end
function sqrdist(x,y) return x*x+y*y end
function frnd(a) return flr(rnd(a)) end