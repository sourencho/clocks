function any(xs, cond)
    for x in all(xs) do
        if cond(x) then
            return true
        end
    end
    return false
end

function tern(cond, T, F) if cond then return T else return F end end
function pick(ar,k) k=k or #ar return ar[flr(rnd(k))+1] end
function lerp(var,target,pow) return var+pow*(target-var) end