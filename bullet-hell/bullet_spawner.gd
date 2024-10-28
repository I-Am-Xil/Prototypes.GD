extends Node2D


@export var BulletScene: PackedScene

@onready var player_node = get_parent()
@onready var fire_rate_timer = $Timer

const ARM_NUMBER = 24
const INACCURACY = 0.0
const FIRE_RATE = 1
const BULLET_SPEED = 100

func _ready() -> void:
    return


func _physics_process(delta: float) -> void:

    if Input.is_action_just_pressed("Shoot"):
        if fire_rate_timer.is_stopped():
            fire_rate_timer.start(0.3)

    if Input.is_action_pressed("Shoot"):
        if fire_rate_timer.time_left < fire_rate_timer.wait_time - delta:
            return

        var arm_counter = 0
        var multi_shot = int(1/(delta))

        for i in range(multi_shot):
            var bullet = BulletScene.instantiate()
            bullet.position = global_position
            # bullet.rotation = shooting_pattern(player_node.rotation, arm_number, arm_counter, inaccuracy, 5*Time.get_ticks_msec()/1000.0)
            bullet.rotation = shooting_pattern(0, ARM_NUMBER, arm_counter, INACCURACY, Time.get_ticks_msec()/1000.0)
            bullet.bullet_speed = BULLET_SPEED
            arm_counter += 1
            if arm_counter >= ARM_NUMBER:
                arm_counter = 0
            player_node.add_sibling(bullet)
        return

    if Input.is_action_just_released("Shoot"):
        fire_rate_timer.stop()
        return

    return


func _process(_delta: float) -> void:
    pass


func shooting_pattern(initial_rotation: float, arm_number: int, arm_counter: int, inaccuracy: float, offset: float):
    return initial_rotation + 2*arm_counter*PI/arm_number + offset + randf_range(-inaccuracy, inaccuracy)
