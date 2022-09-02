function update_cors(cors)
    for cor, obj in pairs(cors) do
        _,exc = coresume(cor, obj)
        if exc then
            printh("coroutine error: "..exc)
            stop(trace(co,exc))
        end
        if costatus(cor) == 'dead' then
            cors[cor] = nil
        end
    end
end

-- invoke a function after some time
-- args = {frame_count, func}
function delay_invoke(args)
    local n,f = args[1], args[2]
    for i=0,n do
        yield()
    end
    f()
end

-- invoke a function for some time
-- args = {frame_count, func, func_args}
function dur_invoke(args)
    local n,f,a = args[1], args[2], args[3]
    for i=0,n do
        f(unpack(a))
        yield()
    end
end