function particles(x,y,n,clrs)
    for i=1,n do
        create_particle(x,y,pick(clrs))
    end
end

function create_particle(x, y, c)
    local a, spd = rnd(1), 2 + rnd(5)

    local s = {
        w=2,
        h=2,
        spdcap=3,
        decx=0.8,
        decy=0.8,
        z=2,
        vz=2.5,
        t=0.5,
        regs={"to_update", "to_draw4"},
        x=x,
        y=y,
        c=c,
        vx=spd*cos(a),
        vy=spd*sin(a),
        update=update_particle,
        draw=draw_particle
    }
    register_object(s)
end

function update_particle(s)
    s.t+=0.01
    update_movement(s,0,0)

    s.z+=s.vz
    s.vz-=0.4
    
    if s.z<0 then
        s.z=0
        s.vz*=-0.5
     
        if s.vz<1.2 then
            s.vz=0
        end
    end
    
    if s.t>0.8 then
        deregister_object(s)
    end
end

function draw_particle(s)
    local y=s.y-s.z
    circ(s.x,y,1,s.c)
    pset(s.x,y,s.c)
end

function cloud_particles(x,y,sp,rs,n,clrs)
    for i=1,n do
        create_cloud_particle(x,y,rnd(),sp,pick(rs),pick(clrs))
    end
end

function create_cloud_particle(x,y,a,sp,r,c)
	local p={
		x=x,
		y=y,
		a=a,
		sp=sp,
		r=r,
		c=c,
        regs={"to_update", "to_draw4"},
        update=update_cloud_particle,
        draw=draw_cloud_particle
	}

    register_object(p)
end

function update_cloud_particle(p)
	p.r -= 0.2
	p.sp=lerp(p.sp, 0, 0.09)
	
	p.x+=cos(p.a)*p.sp
	p.y+=sin(p.a)*p.sp
	
	if(p.r < 0) deregister_object(p)
end

function draw_cloud_particle(p)
	circfill(p.x,p.y,p.r,p.c)
end