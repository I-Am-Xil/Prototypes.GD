extends CharacterBody2D


const ACCELERATION = 50
const FRICTION = 25
const MAX_SPEED = 2


func _ready() -> void:
    return


func _process(delta: float) -> void:

    velocity = move_character(delta)
    move_and_collide(velocity)


func move_character(delta: float) -> Vector2:
    var direction = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
    if direction:
        rotation = direction.angle()

    var speed = ACCELERATION
    if direction == Vector2.ZERO:
        speed = FRICTION

    var local_velocity = velocity
    local_velocity.x = move_toward(local_velocity.x, direction.x*MAX_SPEED, delta*speed)
    local_velocity.y = move_toward(local_velocity.y, direction.y*MAX_SPEED, delta*speed)
    return local_velocity
