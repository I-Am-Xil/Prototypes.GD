extends CharacterBody2D

@export var ACCELERATION = 10
@export var FRICTION = 50
@export var MAX_SPEED = 5

@export var FOLLOWER_DISTANCE = 10

@export var GHOST_DURATION = 0.3
@export var GHOST_NUMBER = 3

@onready var Ghost_Sprite1 = $Ghost1
@onready var Ghost_Sprite2 = $Ghost2

@export var Ghost_Scene: PackedScene

var ghosts = []


func sigmoid(x):
    return 1.0 / (1.0 + exp(-x))


func _ready() -> void:
    Ghost_Sprite1.modulate.a = 0.6
    Ghost_Sprite2.modulate.a = 0.3

    create_ghost(GHOST_NUMBER, GHOST_DURATION)
    return


func _process(delta: float) -> void:
    #follower_effect(Ghost_Sprite1, FOLLOWER_DISTANCE)
    #follower_effect(Ghost_Sprite2, FOLLOWER_DISTANCE*2)

    if ghosts:
        for ghost in ghosts:
            ghost.modulate.a = remap(ghost.get_node("Timer").time_left, 0, GHOST_DURATION, 0, 1)
            ghost.modulate.v = remap(ghost.get_node("Timer").time_left, 0, GHOST_DURATION, 0, 1)

    move_character(delta)
    move_and_collide(velocity)
    return


func move_character(delta):
    var direction = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
    var speed = ACCELERATION

    if direction == Vector2.ZERO:
        speed = FRICTION

    velocity.x = move_toward(velocity.x, direction.x * MAX_SPEED, delta * speed)
    velocity.y = move_toward(velocity.y, direction.y * MAX_SPEED, delta * speed)

    return


func follower_effect(sprite, distance):
    sprite.global_position.x = move_toward(
    sprite.global_position.x,
    position.x - sqrt(abs(velocity.x)) * sign(velocity.x) * distance,
    ACCELERATION
    )
    sprite.global_position.y = move_toward(
    sprite.global_position.y,
    position.y - sqrt(abs(velocity.y)) * sign(velocity.y) * distance,
    ACCELERATION
    )
    return


func create_ghost(ghost_number, ghost_duration):
    for i in range(ghost_number):
        var ghost = Ghost_Scene.instantiate()

        ghost.get_node("Timer").wait_time = ghost_duration
        ghost.get_node("Timer").timeout.connect(_on_ghost_timer_timeout.bind(ghost))
        ghost.get_node("Timer").autostart = true
        ghost.global_position = position
        ghosts.append(ghost)
        add_sibling.call_deferred(ghost)

        await get_tree().create_timer(ghost_duration/ghost_number).timeout
    return


func animate_ghost():
    if ghosts:
        for ghost in ghosts:
            ghost.modulate.a = remap(ghost.get_node("Timer").time_left, 0, GHOST_DURATION, 0, 1)
            ghost.modulate.v = remap(ghost.get_node("Timer").time_left, 0, GHOST_DURATION, 0, 1)
        return
    return


func _on_ghost_timer_timeout(ghost):
    ghost.global_position = position
    return
