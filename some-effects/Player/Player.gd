extends CharacterBody2D

@export var ACCELERATION = 10
@export var FRICTION = 50
@export var MAX_SPEED = 5

@export var FOLLOWER_DISTANCE = 10
@export var GHOST_DURATION = 0.3
@export var GHOST_NUMBER = 3

@export var Ghost_Scene: PackedScene

@onready var Ghost_Sprite1 = $Ghost1
@onready var Ghost_Sprite2 = $Ghost2

@onready var ghosts = await create_ghosts(GHOST_NUMBER, GHOST_DURATION)


func sigmoid(x: float) -> float:
    return 1.0 / (1.0 + exp(-x))


func _ready() -> void:
    Ghost_Sprite1.modulate.a = 0.6
    Ghost_Sprite2.modulate.a = 0.3
    return


func _process(delta: float) -> void:
    #follower_effect(Ghost_Sprite1, FOLLOWER_DISTANCE)
    #follower_effect(Ghost_Sprite2, FOLLOWER_DISTANCE*2)

    if ghosts:
        animate_ghost(ghosts)

    move_character(delta)
    move_and_collide(velocity)
    return


func move_character(delta: float) -> void:
    var direction = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
    var speed = ACCELERATION

    if direction == Vector2.ZERO:
        speed = FRICTION

    velocity.x = move_toward(velocity.x, direction.x * MAX_SPEED, delta * speed)
    velocity.y = move_toward(velocity.y, direction.y * MAX_SPEED, delta * speed)

    return


func follower_effect(sprite: Sprite2D, distance: float) -> void:
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


func create_ghosts(ghost_number: int, ghost_duration: float) -> Array[Sprite2D]:
    var ghost_list: Array[Sprite2D]
    for i in range(ghost_number):
        var ghost = Ghost_Scene.instantiate()

        ghost.get_node("Timer").wait_time = ghost_duration
        ghost.get_node("Timer").timeout.connect(_on_ghost_timer_timeout.bind(ghost))
        ghost.get_node("Timer").autostart = true
        ghost.global_position = position
        ghost_list.append(ghost)
        add_sibling.call_deferred(ghost)

        await get_tree().create_timer(ghost_duration/ghost_number).timeout
    return ghost_list


func animate_ghost(ghost_list: Array[Sprite2D]) -> void:
    for ghost in ghost_list:
        var ghost_timer = ghost.get_node("Timer")
        ghost.modulate.a = remap(ghost_timer.time_left, 0, ghost_timer.wait_time, 0, 1)
        ghost.modulate.v = remap(ghost_timer.time_left, 0, ghost_timer.wait_time, 0, 1)
    return


func _on_ghost_timer_timeout(ghost: Sprite2D) -> void:
    ghost.global_position = position
    return
