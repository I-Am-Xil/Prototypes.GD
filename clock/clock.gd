extends MeshInstance3D

@onready var indicator = preload("res://indicator.tscn")
var indicator_list = []

func _ready() -> void:
	var n_indicators = 12
	for i in range(n_indicators):
		var local_indicator = indicator.instantiate()
		local_indicator.position = (Vector3(0,0.005,0.45)).rotated(Vector3(0,1,0), 2*i*PI/n_indicators)
		local_indicator.rotate(Vector3(0,1,0), 2*i*PI/n_indicators)
		indicator_list.append(local_indicator)
		add_child(local_indicator)

func _process(delta: float) -> void:
	pass
