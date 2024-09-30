extends Node2D


@export var GRAVITATIONAL_STRENGTH = 10


func _on_area_2d_body_entered(body):
	body.queue_free()
