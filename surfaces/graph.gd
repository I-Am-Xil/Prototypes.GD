extends Node3D

enum TransitionMode {Cycle, Random}

@export_range(1,n_functions) var function:int = 1
@export var duration:int = 1
@export var mode:TransitionMode

const n_functions = 13
const resolution = 75.0
const n_points = resolution * resolution

const point_scene = preload("res://point.tscn")

var point_list = []
var function_progress = 0
var function_morph_progress = 0
var step = 2.0/resolution

var transitioning = false
var next_function = pick_next_function(function)


func _ready() -> void:
	for i in range(n_points):
		var point_instance = point_scene.instantiate()
		point_instance.scale = Vector3.ONE*step
		point_list.append(point_instance)
		self.add_child(point_instance)


func _process(delta: float) -> void:
	function_progress += delta
	if function_progress < duration:
		return update_function()

	if transitioning == false:
		if function_morph_progress >= 1.0:
			function = next_function
			next_function = pick_next_function(function)
			function_morph_progress = 0.0
			function_progress = 0
			return update_function()
		transitioning = true

	function_morph_progress += delta
	if function_morph_progress >= 1.0:
		transitioning = false

	return update_function_transition()


func update_function_transition() -> void:
	var x = 0
	var z = 0
	var v = 0.5*step - 1.0

	for i in point_list:
		if x == resolution:
			x = 0
			z += 1
			v = (z+0.5)*step - 1.0

		var u = (x+0.5)*step - 1.0
		i.position = morph(function_selector(u, v, function), function_selector(u, v, next_function), smoothstep(0.0, 1.0, function_morph_progress))
		x += 1
	return


func update_function() -> void:
	var x = 0
	var z = 0
	var v = 0.5*step - 1.0

	for i in point_list:
		if x == resolution:
			x = 0
			z += 1
			v = (z+0.5)*step - 1.0

		var u = (x+0.5)*step - 1.0
		i.position = function_selector(u, v, function)
		x += 1
	return


func morph(from:Vector3, to:Vector3, progress:float) -> Vector3:
	return from.lerp(to, progress)


func pick_next_function(current_function:int) -> int:
	if current_function > n_functions:
		return 1
	if mode == TransitionMode.Cycle:
		return current_function + 1
	return randi_range(1, n_functions)


func function_selector(u:float, v:float, selection:int) -> Vector3:
	if selection == 1:
		return Math.wave3(u, v, Time.get_ticks_msec()*0.001)
	if selection == 2:
		return Math.multiwave3(u, v, Time.get_ticks_msec()*0.001)
	if selection == 3:
		return Math.ripple3(u, v, Time.get_ticks_msec()*0.002)
	if selection == 4:
		return Math.cylinder(u, v, Time.get_ticks_msec()*0.002)
	if selection == 5:
		return Math.cylinder2(u, v, Time.get_ticks_msec()*0.002)
	if selection == 6:
		return Math.sphere(u, v, Time.get_ticks_msec()*0.002)
	if selection == 7:
		return Math.sphere2(u, v, Time.get_ticks_msec()*0.002)
	if selection == 8:
		return Math.sphere3(u, v, Time.get_ticks_msec()*0.002)
	if selection == 9:
		return Math.sphere4(u, v, Time.get_ticks_msec()*0.002)
	if selection == 10:
		return Math.sphere5(u, v, Time.get_ticks_msec()*0.002)
	if selection == 11:
		return Math.torus(u, v, Time.get_ticks_msec()*0.002)
	if selection == 12:
		return Math.idk(u, v, Time.get_ticks_msec()*0.002)
	if selection == 13:
		return Math.idk2(u, v, Time.get_ticks_msec()*0.002)
	return Vector3.ZERO
