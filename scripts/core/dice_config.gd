extends Resource
class_name DiceConfig

@export var faces: Array[int] = [1, 2, 3, 4, 5, 6]

@export var regions: Dictionary = {} 

func get_random_face() -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return faces[rng.randi() % faces.size()]
