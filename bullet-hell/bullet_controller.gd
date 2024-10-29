extends Sprite2D


@onready var viewport_size = get_viewport().size
@onready var viewport_rect = get_viewport().get_visible_rect()


const PADDING: float = 20.0
var free_zone_padding: Vector2 = Vector2(PADDING, PADDING)
@onready var free_zone: Rect2 = Rect2(viewport_rect.position - free_zone_padding, viewport_rect.end + free_zone_padding)


var bullet_speed = 1000


func _ready() -> void:
    return


func _physics_process(delta: float) -> void:
    position += bullet_dance_controller(bullet_speed*delta, rotation)

    if (position.x < free_zone.position.x or position.y < free_zone.position.y) or (position.x > free_zone.end.x or position.y > free_zone.end.y):
        queue_free()
    return


func _process(_delta: float) -> void:
    pass


func bullet_dance_controller(x_prime: float, angle: float):
    var bullet_dance: Vector2 = Vector2(x_prime, 0).rotated(angle)
    return bullet_dance
