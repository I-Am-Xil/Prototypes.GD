extends Node2D


@onready var pet_sprite = $PetSprite
@onready var pet_dimensions = Vector2i(pet_sprite.texture.get_height(), pet_sprite.texture.get_width())
@onready var screen_size = Vector2i(DisplayServer.screen_get_size())

@onready var pet_position = get_window().position

enum {NOT_FOLLOWING, FOLLOWING}

var is_following = NOT_FOLLOWING


func _ready() -> void:
    get_window().size = pet_dimensions
    return


func _process(_delta: float) -> void:
    var mouse_position = DisplayServer.mouse_get_position()
    if Input.is_action_just_pressed("Interact"):
        print("Quack!")

        if is_following == FOLLOWING:
            is_following = NOT_FOLLOWING
            pet_sprite.modulate.r = 1
            return
        is_following = FOLLOWING
        pet_sprite.modulate.r = 255

        var pet_limits = screen_size - 2*pet_dimensions
        pet_position = Vector2i(pet_dimensions.x + randi()%pet_limits.x, pet_dimensions.y + randi()%pet_limits.y)

    if pet_position and is_following == FOLLOWING:
        var final_pet_position = mouse_position - round(pet_dimensions/2)
        var pet_movement_direction = Vector2(final_pet_position - get_window().position).normalized()

        # Vector2i limits move_toward's function output. Type cast to Vector2 to fix it
        pet_position = Vector2(pet_position)
        pet_position.x = move_toward(pet_position.x, final_pet_position.x, abs(pet_movement_direction.x))
        pet_position.y = move_toward(pet_position.y, final_pet_position.y, abs(pet_movement_direction.y))

    get_window().position = Vector2i(pet_position)
