extends Node2D

@onready var planets = get_tree().current_scene.get_node("Planets").get_children()
@onready var player = $Player

var planet_positions = []
var direction_vectors = []


func _ready():
	get_planets_positions()


func _physics_process(delta):
	move_player(delta)


func get_planets_positions():
	for planet in planets:
		planet_positions.append(planet.global_position)


func get_distance_player_to_planet():
	direction_vectors = []
	var distances = []
	
	for planet_position in planet_positions:
		var direction = planet_position - player.global_position
		
		direction_vectors.append(direction.normalized())
		distances.append((direction).length() / 100)
	return distances


func calculate_gravitational_forces():
	var planet_distances_to_player = get_distance_player_to_planet()
	var forces = []
	
	for i in range(planets.size()):
		forces.append(planets[i].GRAVITATIONAL_STRENGTH / (planet_distances_to_player[i] ** 2))
	return forces


func sum_gravitational_vectors():
	var forces = calculate_gravitational_forces()
	var resultant_vector = Vector2.ZERO
	
	for i in range(forces.size()):
		resultant_vector += forces[i] * direction_vectors[i]
	return resultant_vector


func move_player(delta):
	if not player: return
	player.velocity += sum_gravitational_vectors() * delta
