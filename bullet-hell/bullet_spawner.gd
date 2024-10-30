extends Node2D


@export var BulletScene: PackedScene

@onready var player_node:CharacterBody2D = get_parent()
@onready var fire_rate_timer: Timer = $Timer

const ARM_NUMBER: float = 6.0
const DISPERSION: float = 0.0
const FIRE_RATE: float = 1.0/60.0 #NOTE: Anything above the physics update frame rate makes no sense
const BULLET_SPEED: int = 200
const MULTISHOT: int = 1

enum {VOID_FIRST_BULLET = 1}

var bullet_dance: int = 0


func _physics_process(delta: float) -> void:
    if Input.is_action_pressed("Shoot"):
        bullet_dance += 1
        if fire_rate_timer.is_stopped():
            fire_rate_timer.start(FIRE_RATE)

    if Input.is_action_just_released("Shoot"):
        await fire_rate_timer.timeout
        fire_rate_timer.stop()
        bullet_dance = 0
        return

    #NOTE: Desperation statement a.k.a. fixes weird input handling related bugs
    if fire_rate_timer.time_left < fire_rate_timer.wait_time - delta or fire_rate_timer.is_stopped() or bullet_dance == VOID_FIRST_BULLET:
        return

    var arm_counter: int = 0
    for i in range(ARM_NUMBER*MULTISHOT):
        var bullet = BulletScene.instantiate()
        #NOTE: This zone is literaly just like writing shaders
        #   Make sure to save the ones you like
        #   if pattern is inconsistent: Use the bullet_dance variable instead of Time.get_ticks_msec()
        #   don't worry about the hardcoded constants that's just how pattern creation operations work

        # bullet.rotation = bullet_angle(player_node.rotation, ARM_NUMBER, arm_counter, 3*PI/4.0, DISPERSION, 5*Time.get_ticks_msec()/1000.0)
        # bullet.rotation = bullet_angle(0, ARM_NUMBER, arm_counter, 3*PI/4.0, DISPERSION, Time.get_ticks_msec()/1000.0)
        bullet.rotation = bullet_angle(0.0, ARM_NUMBER, arm_counter, 0.0, DISPERSION, bullet_dance*bullet_dance/10000.0)
        # bullet.rotation = bullet_angle(0.0, ARM_NUMBER, arm_counter, 3*PI/4, DISPERSION, 0.0)
        # bullet.position = global_position
        bullet.position = global_position + 10*Vector2(remap(round((1.0+sin(i))/2.0), 0, 1, -4, 0), 4).rotated(bullet.rotation)
        bullet_dance += 1

        bullet.bullet_speed = BULLET_SPEED
        arm_counter += 1
        if arm_counter >= ARM_NUMBER:
            arm_counter = 0
        player_node.add_sibling(bullet)
    return


func bullet_angle(initial_rotation: float, arm_number: float, arm_counter: int, arm_separation: float, inaccuracy: float, offset: float) -> float:
    return initial_rotation + 2*arm_counter*(PI + arm_separation)/arm_number + offset + randf_range(-inaccuracy, inaccuracy)
