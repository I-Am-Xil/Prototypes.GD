extends Node3D

const function = 12
const resolution = 100.0
const n_points = resolution * resolution

@onready var point_scene = preload("res://point.tscn")
@onready var point_list = []

var step = 2.0/resolution
func _ready() -> void:
	for i in range(n_points):
		var point_instance = point_scene.instantiate()
		point_instance.scale = Vector3.ONE*step
		point_list.append(point_instance)
		self.add_child(point_instance)



func _process(_delta: float) -> void:
	var x = 0
	var z = 0
	var v = 0.5*step - 1.0

	for i in point_list:
		if x == resolution:
			x = 0
			z += 1
			v = (z+0.5)*step - 1.0

		var u = (x+0.5)*step - 1.0

		if function == 1:
			i.position.y = Math.wave(u, Time.get_ticks_msec()*0.002)
		elif function == 2:
			i.position.y = Math.multiwave(u, Time.get_ticks_msec()*0.002)
		elif function == 3:
			i.position.y = Math.ripple(u, Time.get_ticks_msec()*0.002)
		elif function == 4:
			i.position.y = Math.wave2(u, v, Time.get_ticks_msec()*0.001)
		elif function == 5:
			i.position.y = Math.multiwave2(u, v, Time.get_ticks_msec()*0.001)
		elif function == 6:
			i.position.y = Math.ripple2(u, v, Time.get_ticks_msec()*0.002)
		elif function == 7:
			i.position = Math.wave3(u, v, Time.get_ticks_msec()*0.001)
		elif function == 8:
			i.position = Math.multiwave3(u, v, Time.get_ticks_msec()*0.001)
		elif function == 9:
			i.position = Math.ripple3(u, v, Time.get_ticks_msec()*0.002)
		elif function == 10:
			i.position = Math.cylinder(u, v, Time.get_ticks_msec()*0.002)
		elif function == 11:
			i.position = Math.cylinder2(u, v, Time.get_ticks_msec()*0.002)
		elif function == 12:
			i.position = Math.sphere(u, v, Time.get_ticks_msec()*0.002)

		x += 1
		pass
	return
