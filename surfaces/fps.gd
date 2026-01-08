extends Label


func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	self.text = "FPS(ms): %.0f (%.4f) " % [Engine.get_frames_per_second(), 1000.0/Engine.get_frames_per_second()]
