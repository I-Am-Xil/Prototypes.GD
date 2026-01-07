extends Node3D

const density = 10.0
const points = 100.0
const graph_range = points/density

@onready var point_scene = preload("res://point.tscn")
@onready var point_list = []

func _ready() -> void:
	for i in range(points):
		var point_instance = point_scene.instantiate()
		point_instance.scale *= 0.5
		point_instance.position.x = i/density - graph_range/2.0
		point_list.append(point_instance)
		self.add_child(point_instance)


func _process(delta: float) -> void:
	for i in point_list:
		i.position.y = PI*sin(PI*i.position.x+ Time.get_ticks_msec()*0.003)
		pass
	return
