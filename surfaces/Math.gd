class_name Math extends Node

static func wave(x:float, t:float) -> float:
	return sin(PI*(x+t))

static func multiwave(x:float, t:float) -> float:
	var y = sin(PI*(x + t*0.5))
	y += sin(2*PI*(x+t))*0.5
	return y/1.5

static func ripple(x:float, t:float) -> float:
	var d = abs(x)
	var y = sin(4.0*PI*d-t)
	return y/(1.0+10.0*d)


static func wave2(x:float, z:float, t:float) -> float:
	return sin(PI*(x+z+t))

static func multiwave2(x:float, z:float, t:float) -> float:
	var y = sin(PI*(x + t*0.5))
	y += sin(2*PI*(z+t))*0.5
	y += sin(PI*(x+z+t*0.25))
	return y/1.5

static func ripple2(x:float, z:float, t:float) -> float:
	var d = sqrt(x*x + z*z)
	var y = sin(4.0*PI*d-t)
	return y/(1.0+10.0*d)


static func wave3(u:float, v:float, t:float) -> Vector3:
	var p:Vector3
	p.x = u
	p.z = v

	p.y = sin(PI*(u+v+t))
	return p

static func multiwave3(u:float, v:float, t:float) -> Vector3:
	var p:Vector3
	p.x = u
	p.z = v

	p.y = sin(PI*(u + t*0.5))
	p.y += sin(2*PI*(v+t))*0.5
	p.y += sin(PI*(u+v+t*0.25))
	p.y /= 1.5
	return p

static func ripple3(u:float, v:float, t:float) -> Vector3:
	var p:Vector3
	var d = sqrt(u*u + v*v)

	p.x = u
	p.y = sin(4.0*PI*d-t)
	p.z = v
	p.y /= (1.0+10.0*d)
	return p

static func cylinder(u:float, v:float, _t:float) -> Vector3:
	var p:Vector3
	p.x = sin(PI*u)
	p.y = v
	p.z = cos(PI*u)
	return p

static func cylinder2(u:float, v:float, t:float) -> Vector3:
	var p:Vector3
	var r = cos(0.5*PI*v)
	p.x = r*sin(PI*u)
	p.y = v
	p.z = r*cos(PI*u)
	return p

static func sphere(u:float, v:float, t:float) -> Vector3:
	var p:Vector3
	var r = cos(0.5*PI*v)
	p.x = r*sin(PI*u)
	p.y = sin(PI*0.5*v)
	p.z = r*cos(PI*u)
	return p


















