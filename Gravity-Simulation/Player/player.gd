extends CharacterBody2D

@onready var fire = $Fire

@export var LINEAR_ACCELERATION = 400
@export var ANGULAR_ACCELERATION = 5

var flying_direction = Vector2.UP


func _physics_process(delta):
	var input_vector = Input.get_axis("rotate_left", "rotate_right")
	
	fly(delta)
	rotate_ship(input_vector, delta)
	move_and_slide()


func fly(delta):
	if Input.is_action_pressed("fly"):
		velocity += flying_direction * LINEAR_ACCELERATION * delta
		fire.show()
	if Input.is_action_just_released("fly"):
		fire.hide()


func rotate_ship(input_vector, delta):
	if input_vector != 0:
		rotate(input_vector * ANGULAR_ACCELERATION * delta)
		flying_direction = flying_direction.rotated(input_vector * ANGULAR_ACCELERATION * delta)
