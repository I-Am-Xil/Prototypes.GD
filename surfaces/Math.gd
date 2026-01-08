class_name Math extends Node

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

static func cylinder(u:float, v:float, t:float) -> Vector3:
	var p:Vector3
	p.x = sin(PI*u+t)
	p.y = v
	p.z = cos(PI*u+t)
	return p

static func cylinder2(u:float, v:float, t:float) -> Vector3:
	var p:Vector3
	var r = cos(0.5*PI*v)
	p.x = r*sin(PI*u+t)
	p.y = v
	p.z = r*cos(PI*u+t)
	return p

static func sphere(u:float, v:float, t:float) -> Vector3:
	var p:Vector3
	var r = cos(0.5*PI*v)
	p.x = r*sin(PI*u+t)
	p.y = sin(PI*0.5*v)
	p.z = r*cos(PI*u+t)
	return p

static func sphere2(u:float, v:float, t:float) -> Vector3:
	var p:Vector3
	var r = (1.0+sin(PI*t))/2.0
	var s = r*cos(0.5*PI*v)
	p.x = s*sin(PI*u+t)
	p.y = r*sin(PI*0.5*v)
	p.z = s*cos(PI*u+t)
	return p

static func sphere3(u:float, v:float, t:float) -> Vector3:
	var p:Vector3
	var r = (9.0+sin(8*PI*u))/10.0
	var s = r*cos(0.5*PI*v)
	p.x = s*sin(PI*u+t/2.0)
	p.y = r*sin(PI*0.5*v)
	p.z = s*cos(PI*u+t/2.0)
	return p

static func sphere4(u:float, v:float, t:float) -> Vector3:
	var p:Vector3
	var r = (9.0+sin(8*PI*v+t*2.0))/10.0
	var s = r*cos(0.5*PI*v)
	p.x = s*sin(PI*u)
	p.y = r*sin(PI*0.5*v)
	p.z = s*cos(PI*u)
	return p

static func sphere5(u:float, v:float, t:float) -> Vector3:
	var p:Vector3
	var r = (9.0+sin(PI*(6*u + 4*v + t)))/10.0
	var s = r*cos(0.5*PI*v)
	p.x = s*sin(PI*u)
	p.y = r*sin(PI*0.5*v)
	p.z = s*cos(PI*u)
	return p

static func torus(u:float, v:float, t:float) -> Vector3:
	var p:Vector3
	var r1 = (7.0 + sin(PI*(6*u + t/2.0)))/10.0
	var r2 = (3.0 + sin(PI*(8*u + 4*v + 2*t)))/10.0
	var s = r1 + r2*cos(PI*v)
	p.x = s*sin(PI*u)
	p.y = r2*sin(PI*v)
	p.z = s*cos(PI*u)
	return p

static func idk(u:float, _v:float, t:float) -> Vector3:
	var p:Vector3
	var r = 1.0
	p.x = r*sin(PI*u*t)
	p.y = u
	p.z = r*cos(PI*u*t)
	return p

static func idk2(u:float, v:float, t:float) -> Vector3:
	var p:Vector3
	p.x = v*sin(PI*u*t)
	p.y = u
	p.z = v*cos(PI*u*t)
	return p
