extends CharacterBody2D


@export var ACCELERATION = 100
@export var FRICTION = 50
@export var MAX_SPEED = 50


func _ready() -> void:
    return


func _process(delta: float) -> void:
    _move_character(delta)
    move_and_slide()


func _move_character(delta: float) -> void:
    var direction = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
    if direction:
        rotation = direction.angle()

    var speed = ACCELERATION
    if direction == Vector2.ZERO:
        speed = FRICTION

    velocity.x = move_toward(velocity.x, direction.x*MAX_SPEED, delta*speed)
    velocity.y = move_toward(velocity.y, direction.y*MAX_SPEED, delta*speed)
    return
