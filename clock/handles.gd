extends Node3D

@onready var seconds_handle = $Seconds
@onready var minutes_handle = $Minutes
@onready var hours_handle = $Hours

@onready var base_transform_seconds = seconds_handle.transform
@onready var base_transform_minutes = minutes_handle.transform
@onready var base_transform_hours = hours_handle.transform

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	var time_dict = Time.get_time_dict_from_system()
	print(time_dict)
	seconds_handle.transform = base_transform_seconds.rotated(Vector3(0,1,0), -2*PI*time_dict["second"]/60)
	minutes_handle.transform = base_transform_minutes.rotated(Vector3(0,1,0), -2*PI*time_dict["minute"]/60)
	hours_handle.transform = base_transform_hours.rotated(Vector3(0,1,0), -2*PI*time_dict["hour"]/12)
	return
