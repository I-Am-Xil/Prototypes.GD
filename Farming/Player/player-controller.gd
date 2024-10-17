extends CharacterBody2D


@export var ACCELERATION = 10
@export var FRICTION = 50
@export var MAX_SPEED = 5


@onready var hitArea = $HitArea
@onready var cropScene = preload("res://Crops/Crop-template.tscn")

func _ready() -> void:
    hitArea.monitoring = false
    return


func _process(delta: float) -> void:

    hit_object()
    put_object()

    move_character(delta)
    move_and_collide(velocity)
    return


func move_character(delta):
    var direction = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
    var speed = ACCELERATION

    if direction == Vector2.ZERO:
        speed = FRICTION

    velocity.x = move_toward(velocity.x, direction.x*MAX_SPEED, delta*speed)
    velocity.y = move_toward(velocity.y, direction.y*MAX_SPEED, delta*speed)
    return


func hit_object():
    if Input.is_action_pressed("Hit_Object"):
        hitArea.monitoring = true
        return

    hitArea.monitoring = false
    return


func put_object():
    if Input.is_action_just_pressed("Put_Object"):
        var crop = cropScene.instantiate()
        crop.position = global_position

        #! This will change when plowed soil is added
        get_tree().get_root().get_node( get_parent().get_path() ).add_child(crop)
        return

    return


func _on_hit_area_body_entered(body:Node2D) -> void:
    body.queue_free()
    return
