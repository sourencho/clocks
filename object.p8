-- OBJECTS

function update_animt(o)
    o.animt+=0.01
end

function update_objects()
    local uobjs=objs.to_update
    for obj in all(uobjs) do
        obj.update(obj)
    end
end

function draw_objects()
    for i=0,4 do
        local dobjs=objs["to_draw"..i]
        for obj in all(dobjs) do
            obj.draw(obj)

        if (SHOW_DEBUG_OBJ) then
            if (obj.draw_debug != nill) then
                obj:draw_debug()
            end
        end
        end
    end
end

function register_object(o)
    for reg in all(o.regs) do
        add(objs[reg],o)
    end
end

function deregister_object(o)
 for reg in all(o.regs) do
  del(objs[reg],o)
 end
end

function group(name) return all(objs[name]) end
function group_table(name) return objs[name] end