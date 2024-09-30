extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal game_over

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var bird_size = 64

@onready var fixed_screen_size_y = get_viewport_rect().size.y - bird_size

func _ready():
	print(fixed_screen_size_y)

func _process(delta):
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY


func _physics_process(delta):
	velocity.y += gravity * delta
	
	velocity.y = clamp(velocity.y, -400, 400)
	position.y = clamp(position.y, bird_size, fixed_screen_size_y)
	
	if position.y >= fixed_screen_size_y:
		get_tree().paused = true
		emit_signal("game_over")
	
	move_and_slide()
