extends CanvasLayer

@onready var score_label = $"Score Label"
@onready var center_container = $CenterContainer
@onready var end_score_label = $"CenterContainer/VBoxContainer/End Score Label"
@onready var restart_button = $"CenterContainer/VBoxContainer/Restart Button"
@onready var score = 0


func _ready():
	get_tree().paused = false
	score_label.text = str(score)
	center_container.hide()


func _on_tubos_update_score():
	score += 1
	score_label.text = str(score)


func _on_tubos_game_over():
	end_score_label.text = "Score:" + str(score)
	center_container.show()
	score_label.hide()


func _on_player_game_over():
	end_score_label.text = "Score:" + str(score)
	center_container.show()
	score_label.hide()


func _on_restart_button_button_up():
	get_tree().reload_current_scene()


func _on_exit_button_button_up():
	get_tree().quit(0)
