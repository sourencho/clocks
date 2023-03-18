function create_text(x,y,str,c1,c2)
    local txt={
     t=2,
     x=x,
     y=y,
     str=str,
     c1=c1,
     c2=c2
    }
    
    add(floatxts,txt)
end

function update_text()
    for txt in all(floatxts) do
        txt.y-=txt.t
        txt.t-=0.1
        if txt.t<0 then
            del(floatxts,txt)
        end
    end
end

function draw_text(str,x,y,al,c1,c2)
    str=""..str
    local al=al or 1
    local c1=c1 or 7
    local c2=c2 or 13
   
    if al==1 then x-=#str*2-1
    elseif al==2 then x-=#str*4 end
    
    y-=3
    
    print(str,x+1,y+1,c2)
    print(str,x-1,y+1,c2)
    print(str,x,y+2,c2)
    print(str,x+1,y,c2)
    print(str,x-1,y,c2)
    print(str,x,y+1,c2)
    print(str,x,y-1,c2)
    print(str,x,y,c1)
end