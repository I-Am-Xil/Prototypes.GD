extends Node2D


signal update_score
signal game_over


@export var SPEED = 400
@onready var initial_position_x = position.x


func _process(delta):
	position.x -= SPEED * delta
	
	if position.x < -100:
		position.x = initial_position_x
		position.y = randi_range(200, 500)
		emit_signal("update_score")


func _on_tubo_inferior_pause_tubos():
	get_tree().paused = true
	emit_signal("game_over")


func _on_tubo_superior_pause_tubos():
	get_tree().paused = true
	emit_signal("game_over")
