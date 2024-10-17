extends StaticBody2D

@export var grow_stage = 0


@onready var sprite = $Sprite2D


var MAX_CROP_STAGE = 3
var grow_timer_ref


func _ready() -> void:
    grow_timer_ref = create_grow_timer()
    sprite.modulate = Color.RED
    pass 


func _process(_delta: float) -> void:
    return


func create_grow_timer():
    var grow_timer = Timer.new()
    grow_timer.wait_time = randf_range(1.0, 5.0)
    grow_timer.autostart = true
    grow_timer.timeout.connect(_on_timer_timeout)
    add_child(grow_timer)

    return grow_timer


func _on_timer_timeout():
    if grow_stage >= (MAX_CROP_STAGE - 1):
        print("fully grown")
        grow_timer_ref.stop()

    grow_stage += 1
    sprite.modulate = Color.from_hsv(0.25*grow_stage, 1, 1, 1)

    return
